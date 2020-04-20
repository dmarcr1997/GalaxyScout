class AlbumsController < ApplicationController
    before_action :require_login 

    def index
        if params.include?(:search)
            Album.search_albums(params[:search])
            admin = User.find_by(id: 1)
            @albums = admin.albums.uniq(&:title)
            if @albums.nil? || @albums.empty?
                flash[:alert] = "Sorry Nothing matches that search"
            end
        else
            Album.new_albums
            @albums = Album.all.order('created_at DESC').uniq(&:title)
        end
    end

    def show
        @album = Album.find_by(id: params[:id])
        @galaxies = @album.galaxies.uniq(&:name)
        @space_objs = @album.space_objs.uniq(&:name)
        @planets = @album.planets.uniq(&:name)
        if @album.nil?
            redirect_to all_albums_path
        end
    end

    def new
        @album = Album.new
       
    end

    def create
        @album = Album.create(album_params)
        @album.user = current_user
        if @album.save
            tag_relation_conditional(params, @album)
        else
            render 'new'
        end
    end

    def edit
        @album = Album.find_by(:id => params[:id])
    end

    def update
        @album = Album.find_by(:id => params[:id])
        @album.update(album_params)
        if @album.save
            tag_relation_conditional(params, @album)
        else            
            render 'edit'
        end
    end

    def destroy
        # raise params.inspect
        @album = Album.find_by(:id => params[:id])
        if @album.user != current_user 
            redirect_to user_path(current_user)
        else
            @album.destroy
            redirect_to user_path(current_user)
        end
    end    
    
    private
    def album_params
        params.require(:album).permit(:title, :date, :center, :creator, :description, :nasa_id, :href, :options)
    end

    
    def assign_existing(params)
        true if (!params[:album][:planet_ids].empty? || !params[:album][:galaxy_ids].empty? || !params[:album][:space_obj_ids].empty?)
    end

    def tag_relation_conditional(params, album)
        if (album.options != "Other" || !album.options.nil?) && !assign_existing(params)
            set_new_relation(album)
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
end
