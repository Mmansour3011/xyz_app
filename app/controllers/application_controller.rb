class ApplicationController < ActionController::Base

    include SessionsHelper

    def root
      if current_user
        redirect_to todos_path
      else
        redirect_to login_path
      end
    end
end
