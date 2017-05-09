class Dashboard::FlickrsController < ApplicationController

  def index
    render json: FlickrSearchPhotos.new().call(params[:tags])
  end

  def search
  end

  def show 
  end
end
