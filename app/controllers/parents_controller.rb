class ParentsController < ApplicationController
    before_action :set_parent, only: [:show, :edit, :update]
    before_action :check_login, only: [:show, :edit, :update, :index]
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
          flash[:notice] = "#{@parent.p1_first_name} #{@parent.p1_last_name} was added to the system."
          redirect_to parents_path
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
      if @parent.update_attributes(parent_params)
        redirect_to @parent, notice: "Successfully updated #{@parent.p1_last_name}."
      else
          render :action => 'edit'
      end
    end
  
    private
  
      def set_parent
        @parent = Parent.find(params[:id])
      end
  
      def parent_params
        params.require(:parent).permit(:p1_first_name, :p1_last_name, :p2_last_name, :p2_first_name, :email, :phone_number, :open_beds, :family_style, :active, :username, :password, :password_confirmation, :role)
      end
  
      def user_params
        params.require(:parent).permit(:active, :username, :password, :password_confirmation, :role)
      end

end
