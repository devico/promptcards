class Home::HomeController < Home::BaseController
  include CardForReview
  def index
  #@card = obtain_card_review

  #   respond_to do |format|
  #     format.html
  #     format.js
  #   end
  # end
    if params[:id]
      @card = current_user.cards.find(params[:id])
    else
      if current_user.current_block
        @card = current_user.current_block.cards.pending.first
        @card ||= current_user.current_block.cards.repeating.first
      else
        @card = current_user.cards.pending.first
        @card ||= current_user.cards.repeating.first
      end
    end

    respond_to do |format|
      format.html
      format.js
    end
  end
end
