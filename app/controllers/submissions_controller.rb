class SubmissionsController < ApplicationController
    before_action :set_submission, only: [:show, :edit, :update, :destroy]
    before_action :check_login, only: [:show, :edit, :update]
    authorize_resource
  
    def index
    end
  
    def new
      @submission = Submission.new
    end
  
    def create
      @submission = Submission.new(submission_params)
  
      if @submission.save
        redirect_to submission_path(@submission)
      else
        render action: 'new'
      end
    end
  
    def edit
    end
  
    def show
    end
  
    def update
      if @submission.update_attributes(submission_params)
        flash[:notice] = "Successfully updated #{@submission}."
        redirect_to submission_path
      else
        render action: 'edit'
      end
    end
  
    def destroy
    end

    
    private
      def set_submission
        @submission = Submission.find(params[:id])
      end

      def item_params
        params.require(:item).permit(:name, :instructions, :filename, :file, :due_date, :active, :category_id)
      end
      
      def submission_params
        params.require(:submission).permit(date_completed:, :file)
      end
end
