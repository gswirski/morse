class PastesController < ApplicationController
  def index
    @pastes = Paste.by_user(current_user).list.page(params[:page]).per(10)
    respond_with(@pastes)
  end

  def show
    @paste = build_paste
    respond_with(@paste)
  end

  def download
    @paste = build_paste
    send_data(
      @paste.code,
      :filename => @paste.filename,
      :type => "application/shell"
    )
  end

  def new
    @paste = build_paste
  end

  def create
    @paste = build_paste
    unless @paste.save
      flash[:alert] = "You wanted to paste some code, right? :)"
    end
    respond_with @paste
  end

  private

  def build_paste
    if params[:id]
      Paste.find_by_slug(params[:id])
    elsif signed_in?
      current_user.pastes.build(params[:paste])
    else
      Paste.new(params[:paste])
    end
  end
end
