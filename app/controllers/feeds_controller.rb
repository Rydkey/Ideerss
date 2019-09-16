require 'rss'

class FeedsController < ApplicationController


  def index
    @feeds = Feed.all
  end

  def new
    @feed = Feed.new

  end

  def create
    @feed = Feed.new(params.require(:feed).permit(:title, :url))
    respond_to do |format|
      if @feed.save
        fill_items
        format.js
      else
        render 'new'
      end
    end
  end

  def show
    @feed = Feed.find(params[:id])
  end

  def destroy
    @feed = Feed.find(params[:id])
    @feed.destroy
    redirect_to 'feeds_path'
  end

  private

  def feed_params
    params.require(:feed).permit(:title, :url, :description, :link)
  end

  def fill_items
    url = @feed[:url]
    open(url) do |rss|
      feed = RSS::Parser.parse(rss)
      @feed.description = feed.channel.description
      @feed.link = feed.channel.link
      feed.items.each do |item|
        @item = Item.new
        @item.read = false
        @item.feed = @feed
        @item.title = item.title
        @item.pub_date = item.pubDate
        @item.description = item.description
        @item.link = item.link
        @item.save
      end
    end
  end
end
