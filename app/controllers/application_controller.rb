class ApplicationController < ActionController::Base
    helper_method :current_user, :require_login, :search_album, :assign_existing, :tag_relation_conditional, :set_new_relations, :set_relation, :set_both_relations, :categories, :search_user_albums, :facebook_sign, :auth
    def current_user
        User.find_by(id: session[:user_id])
    end

    def require_login
        redirect_to signin_path, alert: 'Must be Logged in to view this action' if current_user.nil?
    end

    def search_user_albums(search)
        @albums = []
        Album.where("title like ?", "%#{search}%").each do |album|    
            @albums << album
        end
        @albums
    end 
   
    def categories
        @categories = ["Galaxy", "Space Object", "Planet", "Other"]
    end

    def auth
        request.env['omniauth.auth']
    end

    def facebook_sign
        @user = User.find_or_create_by(uid: auth['uid']) do |u|
            u.name = auth['info']['name']
            u.email = auth['info']['email']
            u.image = auth['info']['image']
            u.password = auth['uid']
        end
        if @user.save
            session[:user_id] = @user.id
            redirect_to user_path(current_user)
        else
            redirect_to signin_path, alert: 'User could not be found'
        end
    end

    def admin
        admin = User.find_by(:id => 3)
    end
end