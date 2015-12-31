class ItemsController < ApplicationController
  def index
    @items = Item.all
  end
  def new
    @item = Item.new
  end
  def create
    @item = Item.new
    @item.name = params[:item][:name]

    if @item.save
      flash[:notice] = "Item saved"
      redirect_to @item
    else
      flash.now[:alert] = "There was a problem saving your item"
      render :new
    end
  end
end
