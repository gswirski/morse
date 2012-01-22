class RegistrationsController < Devise::RegistrationsController
  prepend_before_filter :authenticate_scope!,
    :only => [:edit, :update, :destroy, :reset_token]

  def reset_token
    current_user.reset_authentication_token!
    redirect_to edit_user_registration_url,
      :notice => "Authentication token reset"
  end

  protected

  def after_update_path_for(resource)
    edit_user_registration_path(resource)
  end
end