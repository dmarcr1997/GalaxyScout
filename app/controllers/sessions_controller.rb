class SessionsController < ApplicationController
    def new
        @user = User.new
    end

    def create
        if params.include?(:user)
            @user = User.find_by(email: user_params[:email])
            if @user
                redirect_to signin_path unless @user.authenticate(user_params[:password])
                session[:user_id] = @user.id
                redirect_to user_path(@user)
            else
                redirect_to signin_path, alert: "Username or password invalid."
            end
        else
            facebook_sign
        end
    end

    def show
    end

    def destroy
        session.delete :user_id
        redirect_to signin_path
    end

    private
    def user_params
        params.require(:user).permit(:email, :password)
    end
  
end
