class CheckTranslation
  require 'super_memo'
  require 'levenshtein'

  def initialize(params)
    @translated_text = params[:translated_text]
    @user_translation = params[:user_translation]
    @review_date = params[:review_date] 
    @interval = params[:interval]
    @repeat = params[:repeat]
    @efactor = params[:efactor]
    @attempt = params[:attempt]
  end

  DISTANCE_LIMIT = 1
  
  def call
    distance = Levenshtein.distance(full_downcase(@translated_text),
                                    full_downcase(@user_translation))
    distance_limit = DISTANCE_LIMIT
    sm_hash = SuperMemo.algorithm({ interval: @interval, 
                                    repeat: @repeat,
                                    efactor: @efactor,
                                    attempt: @attempt,
                                    distance: distance, 
                                    distance_limit: distance_limit })

    result = if distance <= 1
               sm_hash.merge!({ review_date: Time.now + @interval.to_i.days, attempt: 1 })
               { state: true, distance: distance }
             else
               sm_hash.merge!({ review_date: @review_date, attempt: [@attempt + 1, 5].min })
               { state: false, distance: distance }
             end
    return { 
             state: result[:state],
             distance: result[:distance],
             review_date: sm_hash[:review_date],
             attempt: sm_hash[:attempt],
             interval: sm_hash[:interval], 
             efactor: sm_hash[:efactor], 
             repeat: sm_hash[:repeat],
             quality: sm_hash[:quality]
           }
  end

  def full_downcase(str)
    str.mb_chars.downcase.to_s.squeeze(' ').lstrip
  end
end
