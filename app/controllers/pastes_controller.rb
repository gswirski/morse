class PastesController < ApplicationController
  before_filter :authenticate_user!, :only => [:index]
  respond_to :shell, :only => :create

  expose(:pastes) do
    current_user.pastes.order("created_at DESC").page(params[:page]).per(10)
  end

  expose(:paste) do
    if slug = params["paste_id"] || params[:id]
      Paste.find_by_slug(slug).tap do |r|
        r.attributes = params["paste"] unless request.get?
      end
    elsif signed_in?
      current_user.pastes.new(params["paste"])
    else
      Paste.new(params["paste"])
    end
  end

  expose(:groups) { current_user.groups }
  expose(:invitations) { current_user.invitations.count }

  def index
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
    respond_with(paste) do |format|
      format.shell { render :text => paste_url(paste) + "\n" }
    end
  end

  def edit
    authorize! :manage, paste
    respond_with paste
  end

  def update
    authorize! :manage, paste
    paste.save
    respond_with paste
  end

  def destroy
    authorize! :manage, paste
    paste.destroy
    respond_with paste
  end
end
