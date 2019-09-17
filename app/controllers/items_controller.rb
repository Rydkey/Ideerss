class ItemsController < ApplicationController

  def show
    @item = Item.find(params[:id])
  end

  def set_to_read
    @item = Item.find(params[:id])
    respond_to do |format|
      if @item.read == false then
        @item.read = !@item.read
        @item.save
        format.js
      end
    end

  end

  private

  def item_params
    params.permit(:id, :title, :description, :link, :read, :pub_date)
  end
end
