class AssignmentsController < ApplicationController
    before_action :set_assignment, only: [:show, :edit, :update, :destroy]
    before_action :check_login, only: [:show, :edit, :update]
    authorize_resource
  
    def index
      @incomplete_items = Assignment.incomplete.paginate(page: params[:page]).per_page(15)
    end
  
    def new
      @assignment = Assignment.new
    end
  
    def create
      @assignment = Assignment.new(assignment_params)
  
      if @assignment.save
        redirect_to assignment_path(@assignment)
      else
        render action: 'new'
      end
    end
  
    def edit
    end
  
    def show
    end
  
    def update
      if @assignment.update_attributes(assignment_params)
        flash[:notice] = "Successfully updated #{@assignment}."
        redirect_to assignment_path
      else
        render action: 'edit'
      end
    end
  
    def destroy
    end

    
    private
      def set_assignment
        @assignment = Assignment.find(params[:id])
      end
      def case_worker_params
        params.require(:case_worker).permit(:first_name, :last_name, :email, :phone_number, :username, :password, :password_confirmation)
      end

      def foster_parent_params
        params.require(:foster_parent).permit(:first_name, :last_name, :email, :phone_number, :active, :username, :password, :password_confirmation, :open_beds, :family_style)
      end

      def item_params
        params.require(:item).permit(:name, :instructions, :filename, :file, :due_date, :active, :category_id)
      end

      def assignment_params
        params.require(:assignment).permit(due_date:, :completion, :status)
      end
end
