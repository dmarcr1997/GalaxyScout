class GalaxiesController < ApplicationController
    before_action :require_login
    def new
        @galaxy = Galaxy.new
    end

    def create
        @album = Album.find_by(id: session[:album_id])
        @galaxy = Galaxy.find_or_create_by(galaxy_params)
        if @galaxy.save
            @album.galaxies << @galaxy
           session.delete :album_id
           redirect_to galaxy_path(@galaxy)
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
