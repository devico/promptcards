class Dashboard::RegistrationsController < Devise::RegistrationsController
  def destroy
    resource.destroy
    set_flash_message :notice, :destroyed
    sign_out_and_redirect(self.resource)
  end
end
