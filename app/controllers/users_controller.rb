class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      cookies.signed.permanent[:user_id] = @user.id
      redirect_to root_url, notice: "User was successfully created."
    else
      flash.now[:alert] = "An error occurred."
      render "new"
    end
  end
end
