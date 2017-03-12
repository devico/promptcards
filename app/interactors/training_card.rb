class TrainingCard
  include Interactor

  def call
    context.card = if context.card_id
                     cards_current_user
                   else
                     all_cards
                   end
  end

  def cards_current_user
    context.user.cards.find(context.card_id)
  end

  def all_cards
    if context.user.current_block
      card_current_block
    else
      all_cards_user
    end
  end

  def card_current_block
    card = context.user.current_block.cards.pending.first
    card || context.user.current_block.cards.repeating.first
  end

  def all_cards_user
    card = context.user.cards.pending.first
    card || context.user.cards.repeating.first
  end
end
