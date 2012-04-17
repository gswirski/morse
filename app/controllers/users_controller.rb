class UsersController < ApplicationController
  before_filter :authenticate_user!, except: [ :new, :create ]

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

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.authenticate(params[:user][:current_password])
      params[:user].delete(:current_password)

      if @user.update_attributes(params[:user])
        cookies.signed.permanent[:user_id] = nil
        redirect_to root_url, notice: "Password changed successfully. Login again with new credentials."
      else
        flash.now[:alert] = "An error occurred."
        render "edit"
      end
    else
      flash.now[:alert] = "Invalid password."
      render "edit"
    end
  end
end
