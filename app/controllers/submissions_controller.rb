class SubmissionsController < ApplicationController
    before_action :set_submission, only: [:show, :edit, :destroy]
    before_action :check_login, only: [:show, :edit, :create]
    authorize_resource
  
    def index
      if current_user.role?(:case_worker)
        # find a list of submissions by parent and assignment
        @parent = Parent.find_by(id: params[:parent_id])
        @assignment = Assignment.find_by(id: params[:parent_id, :assignment_id])
        @submissions = @assignment.submissions.paginate(page: params[:page]).per_page(15)

        # find a list of all submissions by parent only
        @submissions_by_parent = Submissions.for_parent(@parent.id).paginate(page: params[:page]).per_page(15)
      elsif current_user.role?(:parent)
        @submissions = Submissions.for_parent(current_user).paginate(page: params[:page]).per_page(15)
      end
    end
  
    def new
      @submission = Submission.new
      @item = Item.find(params[:item_id])
      @parent = Parent.find(params[:parent_id])
    end
  
    def create
      @submission = Submission.new(submission_params)
  
      if @submission.save
        flash[:notice] = "Submission for #{@submission.assignment.item.name} was added to the system."
        if current_user.role?(:parent)
          redirect_to item_path(@submission.assignment.item)
        elsif current_user.role?(:case_worker)
          redirect_to parent_show_path(id: @submission.item.id, parent_id: @submission.parent.id)
        end
      else
        render action: 'new'
      end
    end
  
    def edit
    end
  
    def show
    end
  
    def destroy
      @assignment = @submission.assignment
      @parent = @assignment.parent
      @item = @assignment.item

      if @submission.destroy
        flash[:notice] = "Successfully deleted submission of #{@submission.assignment.item.name} from the system."
        redirect_to parent_show_path(id: @item.id, parent_id: @parent.id)
      else
        flash[:notice] = "Unable to delete."
        redirect_to submission_path(@submission)
      end
    end

    
    private
      def set_submission
        @submission = Submission.find(params[:id])
      end
      
      def submission_params
        params.require(:submission).permit(:date_completed, :file, :filename, :item_id, :assignment_id)
      end
end
