class PlanetsController < ApplicationController
    before_action :require_login
    def new
        @planet = Planet.new
    end

    def create
        @album = Album.find_by(id: session[:album_id])
        @planet = Planet.find_or_create_by(planet_params)
        if @planet.save
            @album.planets << @planet
            @album.save
           session.delete :album_id
           redirect_to album_path(@album)
        else
            @album.planets.destroy(@planets)
            render 'new'
        end
    end

    private
    def planet_params
        params.require(:planet).permit(:name, :bio, :picture_src, :size)
    end
    
end
