require "application_responder"

class ApplicationController < ActionController::Base
  protect_from_forgery

  self.responder = ApplicationResponder
  respond_to :html

  rescue_from Security::UserNotAuthenticated, with: :redirect_to_login

  before_filter :authenticate_from_token

  private

  def signed_in?
    cookies.signed[:user_id].present? || @current_user
  end
  helper_method :signed_in?

  def current_user
    @current_user ||= User.find_by_id(cookies.signed[:user_id]) if signed_in?
  end
  helper_method :current_user

  def authenticate_user!
    raise Security::UserNotAuthenticated unless signed_in?
  end

  def authenticate_from_token
    if params[:auth_token].present?
      @current_user ||= User.find_for_token_authentication(params[:auth_token])
    end
  end

  def redirect_to_login
    redirect_to new_session_url
  end
end
