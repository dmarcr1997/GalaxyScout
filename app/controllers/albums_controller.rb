class AlbumsController < ApplicationController
    before_action :require_login 

    def index
        if params.include?(:search)
            Album.search_albums(params[:search])
            super_user = User.find_by(id: 1)
            @albums = super_user.albums.uniq(&:title)
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
            redirect_to albums_path
        end
    end

    def new
        @album = Album.new
       
    end

    def create
        @album = Album.new(album_params)
        @album.user = current_user
        if @album.save
            if !@album.options.include?("Other")
                session[:album_id] = @album.id
                set_relations(@album)
            else 
                redirect_to album_path(@album)
            end
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
            if !@album.options.include?("Other")
                session[:album_id] = @album.id
                set_relations(@album)
            else
                redirect_to album_path(@album)
            end
        else            
            render 'edit'
        end
    end

    def destroy
        @album = Album.find_by(:id => params[:id])
        if @album.user != current_user 
            redirect_to user_path(current_user)
        else
            Album.delete(@album)
            redirect_to albums_path
        end
    end    
    
    private
    def album_params
        params.require(:album).permit(:title, :date, :center, :creator, :description, :nasa_id, :href, :options)
    end
end
