module Responders
  module ShellResponder
    def to_shell
      if has_errors?
        render :text => "Sorry. An error occurred."
      else
        render :text => controller.url_for(resource)
      end
    end
  end
end