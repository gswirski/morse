class PastesController < ApplicationController
  expose(:pastes) { Paste.all }
  expose(:paste)

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
