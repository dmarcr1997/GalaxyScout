class UsersController < ApplicationController
    before_action :require_login, only: [:show]
    def new
        @user = User.new
    end

    def create
        if !auth.nil?
            facebook_sign
        else
            @user = User.new(user_params)
            if @user.name == "admin"
                flash[:alert] = "Cannot use admin as username" 
                render 'new'
            elsif @user.save
                session[:user_id] = @user.id
                redirect_to user_path(@user)
            else
                render 'new'
            end
        end
    end

    def show
        @admin = User.find_by(id: 1)
        @filters = ['Created', 'Commented']
        if params[:search]
            @albums = search_user_albums(params[:search])
            if @albums.empty?
                flash[:alert] = "Sorry Nothing matches that search"
            end
        elsif params[:filter]  
            @albums = filter_user_albums(params[:filter], current_user.albums).uniq(&:title)
        else
            @albums = current_user.albums.order('created_at DESC').uniq(&:title)
        end
    end

    private
    def user_params
        params.require(:user).permit(:name, :password, :passord_confirmation, :image, :email)
    end
end
