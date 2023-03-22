class FosterParentsController < ApplicationController
    before_action :set_foster_parent, only: [:show, :edit, :update]
    before_action :check_login, only: [:show, :edit, :update]
    # authorize_resource
  
    def index
      @active_foster_parents = FosterParent.active.paginate(page: params[:page]).per_page(15)
      @inactive_foster_parents = FosterParent.inactive.paginate(page: params[:page]).per_page(15)
    end
  
    def new
      @foster_parent = FosterParent.new
    end
  
    def create
      @foster_parent = FosterParent.new(foster_parent_params)
      @user = User.new(user_params)
      @user.role = "foster_parent"
      if !@user.save
        @foster_parent.valid?
        render action: 'new'
      else
        @foster_parent.user_id = @user.id
        if @foster_parent.save
          session[:user_id] = @foster_parent.user.id
          flash[:notice] = "#{@foster_parent.proper_name} was added to the system."
          redirect_to foster_parent_path(@foster_parent)
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
    #     if @foster_parent.update_attributes(foster_parent_params)
    #       format.html { redirect_to(@customer, :notice => "Successfully updated #{@customer.proper_name}.") }
    #       format.json { respond_with_bip(@customer) }
    #     else
    #       format.html { render :action => "edit" }
    #       format.json { respond_with_bip(@customer) }
        # end
    #   end
    end
  
    private
  
      def set_foster_parent
        @foster_parent = FosterParent.find(params[:id])
      end
  
      def foster_parent_params
        params.require(:foster_parent).permit(:first_name, :last_name, :email, :phone_number, :active, :username, :password, :password_confirmation, :open_beds, :family_style)
      end
  
      def user_params
        params.require(:user).permit(:active, :username, :role, :password, :password_confirmation)
      end

end
