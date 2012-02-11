class PagesController < ApplicationController
  def shell
    @paste = Paste.find_by_slug("morse")
  end
end
