class FlickrSearchPhotos
  PER_PAGE = 10
 
  def call(tag)
    client.photos.search(tags: tag, per_page: PER_PAGE).each_slice(2)
  end

  private def client
    @client ||= FlickRaw::Flickr.new(
      api_key: Rails.application.secrets.flickr_api_key, 
      shared_secret: Rails.application.secrets.flickr_secret
    )
  end
end
