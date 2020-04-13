class PlanetsController < ApplicationController
    before_action :require_login
    def new
        @album = Album.find_by(id: params[:album_id])
        @planet = Planet.new
    end

    def index
        if params[:album_id]
            @album = Album.find_by(id: params[:album_id])
            if @album.nil?
                redirect_to albums_path, alert: "Cannot find that album"
            else
                @planets = @album.planets
            end
        else
            redirect_to albums_path
        end
    end
    def create
        @album = Album.find_by(id: session[:album_id])
        if @album.nil?
            redirect_to albums_path, alert: "Album not found"
        end
        @planet = Planet.find_or_create_by(planet_params)
        if @planet.save
           @album.planets << @planet
           @album.save
           redirect_to album_path(@album)
        else
            render 'new'
        end
    end

    def show
        @planet = Planet.find_by(:id => params[:id])
    end

    private
    def planet_params
        params.require(:planet).permit(:name, :bio, :picture_src, :size)
    end
    
end
