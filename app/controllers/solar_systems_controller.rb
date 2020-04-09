class SolarSystemsController < ApplicationController
    before_action :require_login
    def new
        @solar_system = SolarSystem.new
    end

    def create
        @album = Album.find_by(id: session[:album_id])
        @solar_system = SolarSystem.new(solar_system_params)
        if @solar_system.save
            @album.solar_systems << @solar_system
           session.delete :album_id
           redirect_to user_path(current_user)
        else
            render 'new'
        end
    end

    private
    def solar_system_params
        params.require(:solar_system).permit(:name, :bio, :picture_src)
    end
    
end
