class PastesController < ApplicationController
  def new
    @paste = Paste.new
  end
  
  def create
    if params[:paste][:code].present?
      flash[:notice] = 'You have created paste successfully'
    else
      flash[:alert] = 'An error occurred'
    end
    redirect_to root_path
  end
end
