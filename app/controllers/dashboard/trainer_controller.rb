class Dashboard::TrainerController < Dashboard::BaseController

  def index
    result = TrainingCard.call(user: current_user, card_id: params[:id])
    @card = result.card
    
    respond_to do |format|
      format.html
      format.js
    end
  end

  def review_card
    @result = ReviewCard.call(
      card_id: current_user.cards.find(params[:card_id]),
      user_translation: trainer_params[:user_translation]
    )

    if @result.state
      flash[:notice] = @result.message
      redirect_to trainer_path
    else
      flash[:alert] = t('.incorrect_translation_alert')
      redirect_to trainer_path(id: @result.card.id)
    end
  end

  private

  def trainer_params
    params.permit(:user_translation)
  end
end
