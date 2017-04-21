class Dashboard::FlickrController < ApplicationController

  def index
    @photos = FlickrSearchPhotos.new(params[:tags]).call

    render template: 'flickr/index', layout: false
  end

  def search
    # FlickRaw.api_key = '9bc714c75d46295d19e2fa6cef21efae'
    # FlickRaw.shared_secret = '5b978b183e15b167'

  #   flickr = FlickRaw::Flickr.new
  #   @photos = flickr.photos.search(:tags => params[:tags], :per_page => 10)

  #   photo = @photos[0]
  #   info = flickr.photos.getInfo(:photo_id => photo.id)
  #   @square_url = FlickRaw.url_s(info)
  #   @original_url = FlickRaw.url_o(info)
  #   #redirect_to flickr_path
  #   #render json: @square_url.to_json
  #   render json: @original_url.to_json
  end
end
