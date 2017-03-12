class ReviewCard
  include Interactor

  def call
    @card = Card.find(context.card_id)
    
    check_result = CheckTranslation.new().call({ 
                     translated_text: @card.translated_text,
                     user_translation: context.user_translation,
                     review_date: @card.review_date,
                     interval: @card.interval,
                     repeat: @card.repeat,
                     efactor: @card.efactor,
                     attempt: @card.attempt })

    @card.update(review_date: check_result[:review_date],
                 attempt: check_result[:attempt],
                 interval: check_result[:interval],
                 efactor: check_result[:efactor],
                 repeat: check_result[:repeat],
                 quality: check_result[:quality])
    
    context.state = check_result[:state]
    context.message = distance_notice(check_result[:distance])
    context.card = @card
  end

  def distance_notice(distance)
    if distance == 0
      I18n.t('dashboard.trainer.correct_translation_notice')
    else
      I18n.t 'dashboard.trainer.translation_from_misprint_alert', 
        user_translation: context.user_translation,
        original_text: @card.original_text,
        translated_text: @card.translated_text
    end
  end
end
