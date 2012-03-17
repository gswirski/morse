class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_username(params[:user][:username])

    if user && user.authenticate(params[:user][:password])
      cookies.signed.permanent[:user_id] = user.id
      redirect_to root_url, notice: "Signed in successfully."
    else
      cookies.signed.permanent[:user_id] = nil
      flash.now[:alert] = "Invalid username or password."
      render "new"
    end
  end

  def destroy
    cookies.signed.permanent[:user_id] = nil
    redirect_to root_url, notice: "Signed out successfully."
  end
end
