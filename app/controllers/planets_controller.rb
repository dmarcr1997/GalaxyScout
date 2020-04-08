class PlanetsController < ApplicationController
    before_action :require_login
    def new
        @planet = Planet.new
    end

    def create
        @album = Album.find_by(id: session[:album_id])
        @planet = Planet.new(planet_params)
        if @planet.save
           @album.galaxies << @planet
           sesssion.delete :album_id
           redirect_to user_path(current_user)
        else
            render 'new'
        end
    end

    private
    def planet_params
        params.require(:planet).permit(:name, :bio, :picture_src, :size)
    end
    
end
