class CategoriesController < ApplicationController
    before_action :set_category, only: [:show, :edit, :update, :destroy, :toggle_active_category]
    before_action :check_login
    authorize_resource
  
    def index
      @active_categories = Category.active.paginate(page: params[:page]).per_page(15)
      @inactive_categories = Category.inactive.paginate(page: params[:page]).per_page(15)
    end
  
    def new
      @category = Category.new
    end

    def show
      @category = Category.find(params[:id])
      @category_items = @category.items
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

    def destroy
      if @category.destroy
        flash[:notice] = "Successfully deleted #{@category.name} from the system."
        redirect_to categories_path
      else
        flash[:notice] = "Unable to delete because there are item(s) in category."
        redirect_to category_path(@category)
      end
    end
  
    def edit

    end
  
    def update
      if @category.update_attributes(category_params)
        flash[:notice] = "Successfully updated #{@category.name}."
        redirect_to categories_path
      else
        render action: 'edit'
      end
    end

    def toggle_active_category
      if @category.active
        @category.update_attribute(:active, false)
        @category.save

        flash[:notice] = "#{@category.name} was made inactive"
        redirect_to category_path(@category)
      else
        @category.update_attribute(:active, true)
        @category.save

        flash[:notice] = "#{@category.name} was made active"
        redirect_to category_path(@category)
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
  