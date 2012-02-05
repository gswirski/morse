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

  def edit
    authorize! :manage, paste
  end

  def update
    authorize! :manage, paste
    paste.update_attributes(params[:paste])
    respond_with(paste)
  end

  def destroy
    authorize! :manage, paste
    paste.destroy
    respond_with(paste)
  end

  def pastes
    @pastes ||= Paste.by_user(current_user)
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
