class ApplicationController < ActionController::Base
    helper_method :current_user, :require_login, :search_album, :set_relations, :categories
    def current_user
        User.find_by(id: session[:user_id])
    end

    def require_login
        redirect_to signin_path, alert: 'Must be Logged in to view this action' if current_user.nil?
    end

    def search_album
        @albums = Album.search_albums(params[:search])
        # add database partial search here
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
