class ParentsController < ApplicationController
    before_action :set_parent, only: [:show, :edit, :update]
    before_action :check_login, only: [:show, :edit, :update]
    # authorize_resource
  
    def index
      @active_parents = Parent.active.paginate(page: params[:page]).per_page(15)
      @inactive_parents = Parent.inactive.paginate(page: params[:page]).per_page(15)
    end
  
    def new
      @parent = Parent.new
    end
  
    def create
      @parent = Parent.new(parent_params)
      @user = User.new(user_params)
      @user.role = "parent"
      if !@user.save
        @parent.valid?
        render action: 'new'
      else
        @parent.user_id = @user.id
        if @parent.save
          session[:user_id] = @parent.user.id
          flash[:notice] = "#{@parent.proper_name} was added to the system."
          redirect_to parent_path(@parent)
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
      if @customer.update_attributes(parent_params)
        redirect_to @customer, notice: "Successfully updated #{@parent.p1_last_name}."
      else
          render :action => 'edit'
      end
    end
  
    private
  
      def set_parent
        @parent = Parent.find(params[:id])
      end
  
      def parent_params
        params.require(:parent).permit(:first_name, :last_name, :email, :phone_number, :active, :username, :password, :password_confirmation, :open_beds, :family_style)
      end
  
      def user_params
        params.require(:parent).permit(:active, :username, :password, :password_confirmation)
      end

end
