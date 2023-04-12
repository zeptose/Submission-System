class ParentsController < ApplicationController
    before_action :set_parent, only: [:show, :edit, :update, :toggle_active_parent]
    before_action :check_login, only: [:show, :edit, :update, :index]
    authorize_resource
  
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
          if !current_user.nil?
            flash[:notice] = "#{@parent.p1_first_name} #{@parent.p1_last_name} was added to the system."
            redirect_to parents_path
          else
            flash[:notice] = "Please login to access #{@parent.p1_first_name} #{@parent.p1_last_name}'s account."
            redirect_to login_path
          end 
        else
          render action: 'new'
        end
      end 
    end
  
  
    def edit
    end
  
    def show
      @parent = Parent.find(params[:id])
    end
  
    def update
      if @parent.update_attributes(parent_params)
        redirect_to @parent, notice: "Successfully updated #{@parent.p1_last_name} Family."
      else
          render :action => 'edit'
      end
    end

    def toggle_active_parent
      if @parent.active
        @parent.update_attribute(:active, false)
        @parent.save

        flash[:notice] = "#{@parent.p1_last_name} family was made inactive"
        redirect_to parent_path(@parent)
      else
        @parent.update_attribute(:active, true)
        @parent.save

        flash[:notice] = "#{@parent.p1_last_name} family was made active"
        redirect_to parent_path(@parent)
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
