require 'rails_helper'
describe FlickrSearchPhotos do

  let(:client) { FlickRaw::Flickr.new(
                 api_key: Rails.application.secrets.flickr_api_key, 
                 shared_secret: Rails.application.secrets.flickr_secret)
               }
  describe 'take photos from flickr' do   
      subject { client.photos.search(tags, per_page) }
      let(:tags) { 'router' }
      let(:per_page) { '10' }
      it 'when take photos from Flickr' do
        VCR.use_cassette('flickr_founded_photos') do
          allow(File).to receive(:exists?).with(/\.jpg$|\.gif$|.png$/).and_return(true)
        end
      end
    end

end
