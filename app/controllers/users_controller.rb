class UsersController < ApplicationController
  def index
    @users = User.page(params[:page]).per(20)
    respond_with(@users)
  end
end
