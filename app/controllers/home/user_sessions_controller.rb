class Home::UserSessionsController < Home::BaseController
  
  def new

  end

  def create
        #user = signin(params[:email], params[:password])
    # if user
    #   redirect_back_or_to root_path, :notice => t('.log_in_is_successful_notice')
    # else
    #   flash.now[:alert] = t('.not_logged_in_alert')
    #   render action: 'new'
    # end
  end
end
