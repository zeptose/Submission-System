class CaseWorkersController < ApplicationController

    before_action :set_case_worker, only: [:show, :edit, :update]
    before_action :check_login, only: [:show, :edit, :update]
    authorize_resource
    
    def index
    end
    
    def new
        @case_worker = CaseWorker.new
    end
    
    def create
        @case_worker = CaseWorker.new(case_worker_params)
        @user = User.new(user_params)
        @user.role = "case_worker"
        if !@user.save
        @case_worker.valid?
        render action: 'new'
        else
        @case_worker.user_id = @user.id
        if @case_worker.save
            session[:user_id] = @case_worker.user.id
            flash[:notice] = "#{@case_worker.proper_name} was added to the system."
            redirect_to case_worker_path(@case_worker)
        else
            render action: 'new'
        end
        end 
    end
    
    
    def edit
    end
    
    def show
    #   @previous_orders = @customer.orders.all.to_a
    #   @addresses = @customer.addresses.all.to_a
    end
    
    def update
    #   respond_to do |format|
    #     if @case_worker.update_attributes(case_worker_params)
    #       format.html { redirect_to(@customer, :notice => "Successfully updated #{@customer.proper_name}.") }
    #       format.json { respond_with_bip(@customer) }
    #     else
    #       format.html { render :action => "edit" }
    #       format.json { respond_with_bip(@customer) }
        end
        end
    end
    
    private
    
        def set_case_worker
          @case_worker = CaseWorker.find(params[:id])
        end
    
        def case_worker_params
            params.require(:case_worker).permit(:first_name, :last_name, :email, :phone_number, :username, :password, :password_confirmation)
        end
    
        def user_params
            params.require(:user).permit(:active, :username, :role, :password, :password_confirmation)
        end
    
    
end
