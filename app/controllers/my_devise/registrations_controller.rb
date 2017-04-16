class MyDevise::RegistrationsController < Devise::RegistrationsController
  before_filter :authenticate_user!, :only => :token

  def new
    super
  end

 
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "You have signed up successfully. If enabled, a confirmation was sent to your e-mail."
      redirect_to root_url
    else
      render :action => :new
    end
  end

  def update
    super
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end 
