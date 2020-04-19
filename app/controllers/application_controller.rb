class ApplicationController < ActionController::Base
    helper_method :current_user, :require_login, :search_album, :set_new_relation, :set_relation, :set_both_relations, :categories, :search_user_albums, :facebook_sign
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
    

    def set_new_relation(album)
        if album.options == "Galaxy"
            redirect_to "/albums/#{album.id}/galaxies/new"
        elsif album.options == "Space Object"
            redirect_to "/albums/#{album.id}/space_objs/new"
        else
            redirect_to "/albums/#{album.id}/planets/new"
        end
    end

    def set_relation(params, album)
        if params[:planet_ids]
            planet = Planet.find_by(:id => params[:planet_ids])
            if !planet.nil?
                album.planets << planet
            end
        elsif params[:galaxy_ids]
            galaxy = Galaxy.find_by(:id => params[:galaxy_ids])
            if !galaxy.nil?
                album.galaxies << galaxy
            end
        else
            space_obj = SpaceObj.find_by(:id => params[:space_obj_ids])
            if !space_obj.nil?
                album.space_objs << space_obj
            end
        end
        redirect_to album_path(album)
    end

    def set_both_relations(params, album)
        if params[:planet_ids]
            planet = Planet.find_by(:id => params[:planet_ids])
            if !planet.nil?
                album.planets << planet
            end
        elsif params[:galaxy_ids]
            galaxy = Galaxy.find_by(:id => params[:galaxy_ids])
            if !galaxy.nil?
                album.galaxies << galaxy
            end
        else
            space_obj = SpaceObj.find_by(:id => params[:space_obj_ids])
            if !space_obj.nil?
                album.space_objs << space_obj
            end
        end
        
        if album.options == "Galaxy"
            redirect_to "/albums/#{album.id}/galaxies/new"
        elsif album.options == "Space Object"
            redirect_to "/albums/#{album.id}/space_objs/new"
        elsif album.options == "Planet"
            redirect_to "/albums/#{album.id}/planets/new"
        end
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
end
