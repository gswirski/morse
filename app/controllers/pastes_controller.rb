class PastesController < ApplicationController
  before_filter :authenticate_user!, :only => [:index, :paste_code]

  expose(:pastes) do
    if signed_in?
      current_user.pastes
    else
      Paste.all
    end
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

  def paste_file
    render :text => current_user.username
  end

  def download
    send_data paste.code,
      :filename => paste.name || "#{paste.slug}.#{paste.syntax}",
      :type => "application/shell"
  end

  def create
    paste.save
    respond_with paste
  end

  def update
    paste.save
    respond_with paste
  end

  def destroy
    paste.destroy
    respond_with paste
  end
end
