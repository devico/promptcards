class FlickrSearchPhotos
  attr_reader :tag, :per_page, :flickr

  def initialize(tag)
    @tag = tag
    @per_page = 10
    @flickr = FlickRaw::Flickr.new(api_key: Rails.application.secrets.flickr_api_key, 
      shared_secret: Rails.application.secrets.flickr_secret
    )
  end
 
  def call
    @flickr.photos.search(tags: @tag, per_page: @per_page).each_slice(2)
  end
end
