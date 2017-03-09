class Dashboard::TrainerController < Dashboard::BaseController

  def index

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

  def review_card
    @result = ReviewCard.call(
      card_id: current_user.cards.find(params[:card_id]),
      user_translation: trainer_params[:user_translation]
    )

    if @result.state
      if @result.distance == 0
        flash[:notice] = t 'dashboard.trainer.correct_translation_notice'
      else
        flash[:alert] = t 'dashboard.trainer.translation_from_misprint_alert', 
                          user_translation: trainer_params[:user_translation],
                          original_text: @result.card.original_text,
                          translated_text: @result.card.translated_text
      end
      redirect_to trainer_path
    else
      flash[:alert] = t('dashboard.trainer.incorrect_translation_alert')
      redirect_to trainer_path(id: @result.card.id)
    end
  end

  private

  def trainer_params
    params.permit(:user_translation)
  end
end
