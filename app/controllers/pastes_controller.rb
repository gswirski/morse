class PastesController < ApplicationController
  def show
    @paste = Paste.find(params[:id])
  end

  def new
    @paste = Paste.new
  end

  def create
    @paste = Paste.new(params[:paste])
    unless @paste.save
      flash[:alert] = "An error occurred."
    end
    respond_with @paste
  end
end
