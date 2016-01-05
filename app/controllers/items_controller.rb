class ItemsController < ApplicationController

  

  def index
    @items = Item.all
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
    @new_item = Item.new

    if @item.save
      flash[:notice] = "Item saved"
      
    else
      flash.now[:alert] = "There was a problem saving your item"
      
    end
  
    respond_to do |format|
      format.html
      format.js
  end
end
  def destroy
    @user = User.find(params[:user_id])
    @item = @user.items.find(params[:id])
    

    if @item.destroy
      flash[:notice] = "Item deleted"
      
    else
      flash.now[:alert] = "There was a problem deleting your item"
      
    end
    respond_to do |format|
      format.html
      format.js
    end
  end
end
