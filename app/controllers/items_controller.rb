class ItemsController < ApplicationController

  def index
    @items = Item.all
  end

  def show
    @item = Item.find(params[:id])
  end

  def set_to_read
    @item = Item.find(params[:id])
    if @item.read == false then
      @item.read = !@item.read
    end
  end

  private

  def feed_params
    params.require(:item).permit(:title, :description, :link, :pub_date, :read)
  end
end
