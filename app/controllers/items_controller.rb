class ItemsController < ApplicationController

  

  def index
    @items = Item.all
  end
  def new
    @item = Item.new
  end
  def create
    @user = User.find(params[:user_id])
    @item = Item.new
    @item.name = params[:item][:name]
    @item.user = @user

    if @item.save
      flash[:notice] = "Item saved"
      redirect_to items_index_path
    else
      flash.now[:alert] = "There was a problem saving your item"
      render :new
    end
  end
end
