class GalaxiesController < ApplicationController
    before_action :require_login
    def new
        @album = Album.find_by(id: params[:album_id])
        @galaxy = Galaxy.new
    end

    def index
        if params[:album_id]
            @album = Album.find_by(id: params[:album_id])
            if @album.nil?
                redirect_to albums_path, alert: "Cannot find that album"
            else
                @galaxies = @album.galaxies
            end
        else
            redirect_to albums_path
        end
    end

    def create
        @album = Album.find_by(id: params[:galaxy][:album_id])
        if @album.nil?
            redirect_to albums_path, alert: "Album not found"
        end

        @galaxy = Galaxy.find_or_create_by(galaxy_params)
        if @galaxy.save
           @album.galaxies << @galaxy
           @album.save
           redirect_to album_path(@album)
        else
            render 'new'
        end
    end

    def show
        @galaxy = Galaxy.find_by(:id => params[:id])
    end

    private
    def galaxy_params
        params.require(:galaxy).permit(:name, :bio, :picture_src, :size)
    end
    
end
