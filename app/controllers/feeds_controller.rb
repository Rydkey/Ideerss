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
      format.js do
        init_feed_from_url
        if @feed.save
          get_items_from_url(false)
        else
          render 'feeds/_feed_errors'
        end
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

  def refresh
    respond_to do |format|
      format.js do
        @feed = Feed.find(params[:id])
        get_items_from_url(true)
        @feed.touch
        @feed.save
      end
    end
  end

  private

  def feed_params
    params.require(:feed).permit(:title, :url, :description)
  end

  def init_feed_from_url
    url = @feed[:url]
    open(url) do |rss|
      feed = RSS::Parser.parse(rss)
      @feed.description = feed.channel.description
    end
  end

  def get_items_from_url(refresh)
    url = @feed[:url]
    open(url) do |rss|
      feed = RSS::Parser.parse(rss)
      if refresh
        items = feed.items.select { |e| e.pubDate > @feed.updated_at }
      else
        items = feed.items
      end
      items.each do |item|
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