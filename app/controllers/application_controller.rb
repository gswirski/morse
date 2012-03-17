require "application_responder"

class ApplicationController < ActionController::Base
  protect_from_forgery

  self.responder = ApplicationResponder
  respond_to :html

  private

  def signed_in?
    cookies.signed[:user_id].present?
  end
  helper_method :signed_in?

  def current_user
    @current_user ||= User.find_by_id(cookies.signed[:user_id]) if signed_in?
  end
  helper_method :current_user
end
