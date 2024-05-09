class SessionsController < ApplicationController
    include (SessionsHelper)

    def new
        if current_user
            redirect_to todos_path
        end
        
    end

    def create
        user =User.find_by(email: params[:session][:email].downcase)
        if user && user.authenticate(params[:session][:password]) && user.isActive?
                reset_session
                log_in user
                redirect_to todos_path
        else
        flash.now[:danger]= "Invalid email or password"
        render "new" ,staus: :unprocessable_entity
        end
    end

    def destroy
        log_out
        redirect_to root_url, status: :see_other
    end

end
