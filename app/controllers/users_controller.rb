class UsersController < ApplicationController
    before_action :require_login, only: [:show]
    def new
        @user = User.new
    end

    def create
        @user = User.new(user_params)
        if @user.save
            session[:user_id] = @user.id
            redirect_to user_path(@user)
        else
            render 'new'
        end
    end

    def show
        @user = current_user
        @albums = current_user.albums.order('created_at DESC').uniq(&:title)
    end

    private
    def user_params
        params.require(:user).permit(:username, :password, :passord_confirmation)
    end
end
