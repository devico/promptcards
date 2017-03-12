class CheckTranslation
  require 'super_memo'
  require 'levenshtein'

  DISTANCE_LIMIT = 1
  
  def call(params)
    distance = Levenshtein.distance(full_downcase(params[:translated_text]),
                                    full_downcase(params[:user_translation]))
    distance_limit = DISTANCE_LIMIT
    sm_hash = SuperMemo.algorithm({ interval: params[:interval], 
                                    repeat: params[:repeat],
                                    efactor: params[:efactor],
                                    attempt: params[:attempt],
                                    distance: distance, 
                                    distance_limit: distance_limit })

    result = if distance <= 1
               sm_hash.merge!({ review_date: Time.now + params[:interval].to_i.days, attempt: 1 })
               { state: true, distance: distance }
             else
               sm_hash.merge!({ review_date: params[:review_date], 
                                attempt: [params[:attempt] + 1, 5].min })
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
