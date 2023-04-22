class ItemsController < ApplicationController


    before_action :set_item, only: [:show, :edit, :update, :toggle_active_item]
    before_action :check_login, only: [:show, :edit, :update]
    authorize_resource
  
    def new
      @item = Item.new
    end
  
    def create
      @item = Item.new(item_params)
  
      if @item.save
        flash[:notice] = "#{@item.name} was added to the system."
        redirect_to item_path(@item)
      else
        render action: 'new'
      end
    end
  
    def edit
    end
  
    def show
      if current_user.role?(:parent)
        # all assignments that have been assigned to the user
        @assignments = Assignment.for_parent(current_user.parent.id).paginate(page: params[:page]).per_page(15)
      end
      
    end
  
    def update
      if @item.update_attributes(item_params)
        flash[:notice] = "Successfully updated #{@item.name}."
        redirect_to item_path
      else
        render action: 'edit'
      end
    end

    def toggle_active_item
      if @item.active
        @item.update_attribute(:active, false)
        @item.save

        flash[:notice] = "#{@item.name} was made inactive"
        redirect_to item_path(@item)
      else
        @item.update_attribute(:active, true)
        @item.save

        flash[:notice] = "#{@item.name} was made active"
        redirect_to item_path(@item)
      end
  end
  
    private
      def set_item
        @item = Item.find(params[:id])
      end
  
      def item_params
        params.require(:item).permit(:name, :instructions, :filename, :file, :due_date, :active, :category_id)
      end
  
  end
  