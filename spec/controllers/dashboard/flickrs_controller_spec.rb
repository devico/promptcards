require 'rails_helper'

RSpec.describe Dashboard::FlickrsController, type: :controller do

  before do
    @user = FactoryGirl.create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
  end

  describe "#index" do

    it "returns a successful response" do
      VCR.use_cassette "flickr/photos" do 
        get :index, format: :json
        expect(response).to be_success
      end      
    end
  end
end
