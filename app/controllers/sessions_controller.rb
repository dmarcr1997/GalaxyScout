class SessionsController < ApplicationController
    def new
        @user = User.new
    end

    def create
        @user = User.find_by(username: params[:user][:username])
        if @user
            redirect_to login_path unless @user.authenticate(params[:user][:password])
            session[:user_id] = @user.id
            redirect_to user_path(@user)
        else
            redirect_to signin_path
        end
    end

    def show
    end

    def destroy
        session.delete :user_id
        redirect_to signin_path
    end
end
