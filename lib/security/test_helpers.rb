module Security
  module TestHelpers
    def sign_in(user)
      controller.class_eval do
        def signed_in?; true; end
      end
      controller.instance_eval do
        @current_user = user
      end
    end

    def sign_out
      controller.class_eval do
        def signed_in?; false; end
      end
      controller.instance_eval do
        @current_user = nil
      end
    end
  end
end
