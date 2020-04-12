class UsersController < ApplicationController
    before_action :require_login, only: [:show]
    def new
        @user = User.new
    end

    def create
        @user = User.new(user_params)
        if @user.username == "admin"
           flash[:alert] = "Cannot use admin as username" 
           render 'new'
        elsif @user.save
            session[:user_id] = @user.id
            redirect_to user_path(@user)
        else
            render 'new'
        end
    end

    def show
        if params[:search]
            @albums = search_user_albums(params[:search])
            if @albums.empty?
                flash[:alert] = "Sorry Nothing matches that search"
            end
        else  
            @albums = current_user.albums.order('created_at DESC').uniq(&:title)
        end
    end

    private
    def user_params
        params.require(:user).permit(:username, :password, :passord_confirmation)
    end
end
