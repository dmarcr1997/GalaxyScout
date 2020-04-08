class UsersController < ApplicationController
    
    def show
        @user = current_user
        require_login
        @albums = current_user.albums
    end

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

    private
    def user_params
        params.require(:user).permit(:username, :password, :passord_confirmation)
    end
end
