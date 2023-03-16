class ItemsController < ApplicationController


    before_action :set_item, only: [:show, :edit, :update, :destroy, :toggle_active, :toggle_feature]
    #before_action :check_login, only: [:show, :edit, :update]
    authorize_resource
  
    def index
      @categories = Category.active.all
      if params[:category]
        @category = Category.find(params[:category])
      end

    end
  
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
    end
  
    def update
      if @item.update_attributes(item_params)
        flash[:notice] = "Successfully updated #{@item}."
        redirect_to item_path
      else
        render action: 'edit'
      end
    end
  
    def destroy
      if @item.order_items.empty?
        @item.destroy
        flash[:notice] = "#{@item.name} was made inactive, because it cannot be deleted."
        redirect_to items_url
      else
        flash[:notice] = "#{@item.name} was removed from the system."
        redirect_to item_path(@item.id)
      end
    end
  
    
    
    private
      def set_item
        @item = Item.find(params[:id])
      end
  
      def item_params
        params.require(:item).permit(:name, :insturctions, :file, :due_date, :active, :category_id)
      end
  
  end
  