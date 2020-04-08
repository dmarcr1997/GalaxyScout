class UsersController < ApplicationController
    
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
        require_login
        @user = current_user
        @albums = current_user.albums
    end

    private
    def user_params
        params.require(:user).permit(:username, :password, :passord_confirmation)
    end
end
