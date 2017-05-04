class Dashboard::FlickrsController < ApplicationController

  def index
    # @photos = FlickrSearchPhotos.new().call(params[:tags])
    # render :index
    # respond_to json { render json: { 
    #                 'html' => render_to_string(partial: 'photos.html.erb', locals: { photos: @photos })
    #               }
    #   }
    render json: FlickrSearchPhotos.new().call(params[:tags])
  end

  def search
  end

  def show 
  end
end
