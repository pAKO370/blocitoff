class ItemsController < ApplicationController

  rescue_from Pundit::NotAuthorizedError do
    flash[:alert] = "You're not allowed to do that"
    redirect_to :profile
  end

  def index
    @user = User.find(params[:user_id])#sets @user to use in partails
    @items = @user.items
    authorize @items
  end

  def new
    @item = Item.new
    @user = User.find(params[:user_id])
  end
  
  def create
    @user = User.find(params[:user_id])
    @item = Item.new
    @item.name = params[:item][:name]
    @item.user = @user
    #@new_item = Item.new
    authorize @item

    if @item.save
      flash[:notice] = "Item saved"
      redirect_to user_items_path
    else
      flash.now[:alert] = "There was a problem saving your item"
    end
  
    #respond_to do |format| # for ajax
      #format.html
     # format.js
    #end
  end

  def destroy
    @user = User.find(params[:user_id])
    @item = @user.items.find(params[:id])
    
    if @item.destroy
      flash[:notice] = "Item deleted"
    else
      flash.now[:alert] = "There was a problem deleting your item"
    end
    respond_to do |format| # for ajax
      format.html
      format.js
    end
  end

  def edit
    @user = User.find(params[:user_id])
    @item = Item.find(params[:id])
  end

  def update
    @user = User.find(params[:user_id])
    @item = Item.find(params[:id])
    @item.name = params[:item][:name]
    @item.user = @user
    
    #authorize @item
    
    if @item.save
      flash[:notice] = "Item was edited"
      redirect_to user_items_path
    else
      flash.now[:alert] = "There was a problem editing your item"
    end
  end

  def destroy_multiple
    @user = User.find(params[:user_id])
    @items = Item.where(id: params[:item_ids])
    authorize @items
    if @items.destroy_all
      flash[:notice] = "Items deleted"
      redirect_to :root
    else
      puts "not destroyed"
      flash[:alert] = "There was a problem deleting your item"
      redirect_to :root
    end
  end
end
