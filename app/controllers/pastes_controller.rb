class PastesController < ApplicationController
  before_filter :authenticate_user!, :only => [:index]
  respond_to :shell, :only => :create

  helper_method :pastes, :paste

  def index
    @pastes = pastes.page(params[:page]).per(10)
    respond_with(pastes)
  end

  def show
    respond_with(paste)
  end

  def download
    send_data paste.code,
      :filename => paste.filename,
      :type => "application/shell"
  end

  def create
    paste.save
    respond_with(paste)
  end

  def update
    paste.update_attributes(params[:paste])
    respond_with(paste)
  end

  def destroy
    paste.destroy
    respond_with(paste)
  end

  def pastes
    @pastes ||= current_user.pastes
  end

  def paste
    return @paste if @paste
    
    slug = params[:paste_id] || params[:id]
    if slug
      @paste = Paste.find_by_slug(slug)
    elsif signed_in?
      @paste = pastes.build(params[:paste])
    else
      @paste = Paste.new(params[:paste])
    end
  end
end
