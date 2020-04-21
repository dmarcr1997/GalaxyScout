class ApplicationController < ActionController::Base
    helper_method :current_user, :require_login, :search_album, :assign_existing, :tag_relation_conditional, :set_new_relations, :set_relation, :set_both_relations, :categories, :search_user_albums, :facebook_sign, :auth, :filter_user_albums
    def current_user
        User.find_by(id: session[:user_id])
    end

    def filter_user_albums(filter, albums)
        sorted_albums = []
        albums.each do |album|
            if filter[:option] == 'Created'
                sorted_albums << album if album.user_id == current_user.id
            elsif filter[:option] == 'Commented'
                sorted_albums << album if album.user_id !=current_user.id
            else
            end
        end
        return sorted_albums
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
    
    # --------------------------------
    def assign_existing(params)
        true if (!params[:album][:planet_ids].empty? || !params[:album][:galaxy_ids].empty? || !params[:album][:space_obj_ids].empty?)
    end

    def tag_relation_conditional(params, album)
        if (album.options != "Other" || !album.options.nil?) && !assign_existing(params)
            set_new_relations(album)
        elsif assign_existing(params) && (album.options == ("Other") || album.options.nil?)
            set_relation(params[:album], album)
        elsif (album.options != "Other" || !album.options.nil?) && assign_existing(params)
            set_both_relations(params[:album], album)
        else
            redirect_to album_path(album)
        end
    end

    def set_new_relations(album)
        if album.options == "Galaxy"
            redirect_to new_album_galaxy_path(album)
        elsif album.options == "Space Object"
            redirect_to new_album_space_obj_path(album)
        else
            redirect_to new_album_planet_path(album)
        end
    end

    def set_relation(params, album)
        if params[:planet_ids]
            planet = Planet.find_by(:id => params[:planet_ids])
            if !planet.nil?
                album.planets << planet
            end
        end
        if params[:galaxy_ids]
            galaxy = Galaxy.find_by(:id => params[:galaxy_ids])
            if !galaxy.nil?
                album.galaxies << galaxy
            end
        end
        if params[:space_obj_ids]
            space_obj = SpaceObj.find_by(:id => params[:space_obj_ids])
            if !space_obj.nil?
                album.space_objs << space_obj
            end
        end
        album.save
        redirect_to album_path(album)
    end

    def set_both_relations(params, album)
        if params[:planet_ids]
            planet = Planet.find_by(:id => params[:planet_ids])
            if !planet.nil?
                album.planets << planet
            end
        end
        if params[:galaxy_ids]
            galaxy = Galaxy.find_by(:id => params[:galaxy_ids])
            if !galaxy.nil?
                album.galaxies << galaxy
            end
        end
        if params[:space_obj_ids]
            space_obj = SpaceObj.find_by(:id => params[:space_obj_ids])
            if !space_obj.nil?
                album.space_objs << space_obj
             end
        end
        album.save
        if album.options == "Galaxy"
            redirect_to "/albums/#{album.id}/galaxies/new"
        elsif album.options == "Space Object"
            redirect_to "/albums/#{album.id}/space_objs/new"
        elsif album.options == "Planet"
            redirect_to "/albums/#{album.id}/planets/new"
        else 
            redirect_to "/albums/#{album.id}"
        end
    end
    
    #--------------------------------- 
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