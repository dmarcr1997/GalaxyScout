class SessionsController < ApplicationController
    def new
        @user = User.new
    end

    def create
        if auth['info']
            @user = User.find_or_create_by(uid: auth['uid']) do |u|
                u.name = auth['info']['name']
                u.email = auth['info']['email']
                u.image = auth['info']['image']
                u.password = auth['uid']
            end
            binding.pry
            @user.save
            if @user
                session[:user_id] = @user.id
                redirect_to user_path(current_user)
            else
                redirect_to signin_path, alert: 'User could not be found'
            end
        else
            @user = User.find_by(email: params[:user][:email])
            if @user
                redirect_to login_path unless @user.authenticate(params[:user][:password])
                session[:user_id] = @user.id
                redirect_to user_path(@user)
            else
                redirect_to signin_path, alert: "Username or password invalid."
            end
        end
    end

    def show
    end

    def destroy
        session.delete :user_id
        redirect_to signin_path
    end

    private
    def auth
        request.env['omniauth.auth']
    end
end
