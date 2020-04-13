class ApplicationController < ActionController::Base
    helper_method :current_user, :require_login, :search_album, :set_relations, :categories, :search_user_albums
    def current_user
        User.find_by(id: session[:user_id])
    end

    def require_login
        redirect_to signin_path, alert: 'Must be Logged in to view this action' if current_user.nil?
    end

    def search_user_albums(search)
        @albums = []
        Album.where("title like ?", "%#{search}%").each do |album|
            if album.user_id != 20
                @albums << album
            end
        end
        @albums
    end 
    

    def set_relations(params)
        if params[:album][:options] == "Galaxy"
            redirect_to new_galaxy_path
        elsif params[:album][:options] == "Space Object"
            redirect_to new_space_obj_path
        else
            redirect_to new_planet_path
        end
    end

    def categories
        @categories = ["Galaxy", "Space Object", "Planet", "Other"]
    end
end
