class Dashboard::CardsController < Dashboard::BaseController
  require 'flickraw'
  before_action :set_card, only: [:destroy, :edit, :update]

  def index
    @cards = current_user.cards.all.order('review_date')
  end

  def new
    @card = Card.new
  end

  def edit
  end

  def create
    @card = current_user.cards.build(card_params)
    if @card.save
      redirect_to cards_path
    else
      respond_with @card
    end
  end

  def update
    if @card.update(card_params)
      redirect_to cards_path
    else
      respond_with @card
    end
  end

  def destroy
    @card.destroy
    respond_with @card
  end

  def search
    FlickRaw.api_key = '9bc714c75d46295d19e2fa6cef21efae'
    photos = flickr.photos.search(:tags => params[:tags], :per_page => 10)
    @piece = render_to_string :partial => 'photo.text',
      :collection => photos.map { |photo| { :square => FlickRaw.url_s(photo), :big => FlickRaw.url(photo) }}
  end

  private

  def set_card
    @card = current_user.cards.find(params[:id])
  end

  def card_params
    params.require(:card).permit(:original_text, :translated_text, :review_date,
                                 :image, :image_cache, :remove_image, :block_id)
  end
end
