class CategoriesController < ApplicationController
    before_action :set_category, only: [:edit, :update]
    # before_action :check_login
    # authorize_resource
  
    def index
      @active_categories = Category.active.paginate(page: params[:page]).per_page(15)
      @inactive_categories = Category.inactive.paginate(page: params[:page]).per_page(15)
    end
  
    def new
      @category = Category.new
    end
  
    def create
      @category = Category.new(category_params)
      if @category.save
        flash[:notice] = "Successfully added #{@category.name} to the system."
        redirect_to categories_path
      else
        render action: 'new'
      end
    end
  
    def edit
    end
  
    def update
      if @category.update_attributes(category_params)
        flash[:notice] = "Successfully updated #{@category}."
        redirect_to categories_path
      else
        render action: 'edit'
      end
    end
  
    private
      def category_params
          params.require(:category).permit(:name, :active)
      end
  
      def set_category
          @category = Category.find(params[:id])
      end
  end
  