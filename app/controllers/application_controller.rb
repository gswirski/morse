require "application_responder"

class ApplicationController < ActionController::Base
  protect_from_forgery

  respond_to :html
  responders :flash, :http_cache, :shell

  rescue_from ActiveRecord::RecordNotFound, :with => :render_not_found
  rescue_from ActionController::RoutingError, :with => :render_not_found
  rescue_from ActionController::UnknownController, :with => :render_not_found
  rescue_from AbstractController::ActionNotFound, :with => :render_not_found
  rescue_from Security::UserNotAuthenticated, with: :redirect_to_login
  rescue_from Security::UserNotAuthorized, with: :redirect_to_login

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

  def authorize!(action, resource)
    authenticate_user!
    method = action.to_s
    method = method[0..-2] if method[-1] == 'e'
    method += "able_by?"
    unless resource.send(method.to_sym, current_user)
      raise Security::UserNotAuthenticated
    end
  end

  def render_not_found(exception)
    message = "\n#{exception.class} (#{exception.message}):\n"
    Rails.logger.warn(message)
    render "error/404", status: 404
  end

  def redirect_to_login(exception)
    redirect_to new_session_url
  end
end
