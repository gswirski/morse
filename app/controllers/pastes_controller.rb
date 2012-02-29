class PastesController < ApplicationController
  def show
    @paste = Paste.find(params[:id])
  end

  def new
    @paste = Paste.new
  end

  def create
    @paste = Paste.new(params[:paste])
    if @paste.save
      flash[:notice] = 'You have created paste successfully'
      redirect_to @paste
    else
      flash[:alert] = 'An error occurred'
      render 'new'
    end
  end
end
