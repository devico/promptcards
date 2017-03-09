class ReviewCard
  include Interactor

  def call
    @card = Card.find(context.card_id)
    
    check_result = CheckTranslation.new({ 
                     translated_text: @card.translated_text,
                     user_translation: context.user_translation,
                     review_date: @card.review_date,
                     interval: @card.interval,
                     repeat: @card.repeat,
                     efactor: @card.efactor,
                     attempt: @card.attempt }).call

    @card.update(review_date: check_result[:review_date],
                 attempt: check_result[:attempt],
                 interval: check_result[:interval],
                 efactor: check_result[:efactor],
                 repeat: check_result[:repeat],
                 quality: check_result[:quality])
             
    context.state = check_result[:state]
    context.distance = check_result[:distance]
    context.card = @card
  end 
end
