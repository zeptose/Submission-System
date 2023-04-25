class CategoriesController < ApplicationController
    before_action :set_category, only: [:show, :edit, :update, :destroy, :toggle_active_category]
    before_action :set_unique_items_by_category_for_parent, only: [:index, :show], if: -> { current_user.role?(:parent) }
    before_action :check_login
    authorize_resource
  
    def index
      @active_categories = Category.active.paginate(page: params[:page]).per_page(15)
      @inactive_categories = Category.inactive.paginate(page: params[:page]).per_page(15)
      if current_user.role?(:parent)
        # all assignments that have been assigned to the user
        @assignments = Assignment.for_parent(current_user.parent.id).paginate(page: params[:page]).per_page(15)
        
        # a list of all the categories that she has been assigned to
        @unique_categories = @assignments.map { |assignment| assignment.item.category }.uniq
        
        # categories that have incomplete assignments, therefore the category is not complete
        @categories_with_incomplete_assignments = @unique_categories.select do |category|
          @assignments.any? { |assignment| assignment.item.category == category && !assignment.completion }
        end

      end
    end
  
    def new
      @category = Category.new
    end

    def show
      @category = Category.find(params[:id])
      @category_items = @category.items
    end

    def item_show
      @category = Category.find(params[:id])
      @parent = Parent.find(params[:parent_id])
      @assignments = Assignment.for_parent(@parent.id).paginate(page: params[:page]).per_page(15)

      @unique_item_count_by_category = Hash.new { |hash, key| hash[key] = Set.new }
      @unique_items_by_category = Hash.new { |hash, key| hash[key] = Set.new }

      @assignments.each do |assignment|
        category = assignment.item.category
        @unique_item_count_by_category[category].add(assignment.item)
        @unique_items_by_category[category].add(assignment.item)
      end

      @unique_item_count_by_category.each do |category, unique_items|
        @unique_item_count_by_category[category] = unique_items.size
      end
      
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

    def set_unique_items_by_category_for_parent
      @assignments = Assignment.for_parent(current_user.parent.id).paginate(page: params[:page]).per_page(15)

      # use a hash function to find unique items associated with each unique category that has been assigned to the user
      @unique_item_count_by_category = Hash.new { |hash, key| hash[key] = Set.new }
      @unique_items_by_category = Hash.new { |hash, key| hash[key] = Set.new }

      @assignments.each do |assignment|
        category = assignment.item.category
        @unique_item_count_by_category[category].add(assignment.item)
        @unique_items_by_category[category].add(assignment.item)
      end

      @unique_item_count_by_category.each do |category, unique_items|
        @unique_item_count_by_category[category] = unique_items.size
      end

    end

    def destroy
      @category = Category.find(params[:id])
    
      begin
        @category.destroy!
        flash[:success] = 'Category was successfully deleted.'
      rescue ActiveRecord::InvalidForeignKey => e
        flash[:error] = 'Cannot delete this Category: there are associated Items.'
      end
      
      redirect_to categories_path
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
  