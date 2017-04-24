class Dashboard::FlickrsController < ApplicationController

  def index
    #@photos = FlickrSearchPhotos.new(params[:tags]).call
    @photos = FlickrSearchPhotos.new().call(params[:tags])
    #render template: 'flickrs/index', layout: false
    render :index
  end

  def search
  end

  def show 
  end
end
