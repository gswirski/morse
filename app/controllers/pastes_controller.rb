class PastesController < ApplicationController
  def show
    @paste = Paste.find_by_slug(params[:id])
  end

  def new
    @paste = Paste.new
  end

  def create
    @paste = Paste.new(params[:paste])
    unless @paste.save
      flash[:alert] = "You wanted to paste some code, right? :)"
    end
    respond_with @paste
  end
end
