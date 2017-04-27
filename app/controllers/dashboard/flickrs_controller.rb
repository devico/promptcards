class Dashboard::FlickrsController < ApplicationController

  def index
    @photos = FlickrSearchPhotos.new().call(params[:tags])
    render :index
  end

  def search
  end

  def show 
  end
end
