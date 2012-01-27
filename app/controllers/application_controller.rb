class ApplicationController < ActionController::Base
  protect_from_forgery
  respond_to :html, :json

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end
end
