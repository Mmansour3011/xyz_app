class UsersController < ApplicationController
    include (UsersHelper)
    include (SessionsHelper)

    before_action :logged_in_user, only: [:index,:edit,:update,:destroy]
    before_action :correct_or_admin_user , only: [:edit,:update]
    before_action :admin_user , only: [:archive]

    def new
        if current_user
            redirect_to todos_path
        else
            @user=User.new
        end
    end

    def create
        @user=User.new(user_params)
        if @user.save
            reset_session
            log_in @user
            flash[:success] = "Welcome to XYZ App!"
            redirect_to todos_path      
            else
            render "new" , status: :unprocessable_entity
        end
    end

    def show
        @user=User.find(params[:id])
    end

    def index
        @users =User.all.where(soft_delete: false,admin: false)
    end

    def edit
        @user=User.find(params[:id])
    end

    def update
        @user=User.find(params[:id])
        if @user.update(user_params)
            flash[:success] = "Profile updated"
            redirect_to todos_path
        else
            render "edit", status: :unprocessable_entity
        end

    end

    def archive
        @user = User.find(params[:id])
        @user.archive
        redirect_to users_path,notice: "User is deleted succesfully!"
    end

    def destroy
        User.find(params[:id]).destroy
        flash[:success] ="User deleted"
        redirect_to users_url,status: :see_other
    end


    private 
    def user_params
        params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    def logged_in_user
        unless logged_in?
            flash[:danger] ="Please log in"
            redirect_to login_url, status: :see_other
        end
    end

    def correct_user
        @user =User.find(params[:id])
        redirect_to(root_url , status: :see_other) unless current_user?(@user)
    end

    def admin_user
        redirect_to(root_url , status: :see_other) unless current_user.admin?
    end

    def correct_or_admin_user
        @user = User.find(params[:id])
        redirect_to(root_url) unless current_user == @user || current_user.admin?
    end

   




end