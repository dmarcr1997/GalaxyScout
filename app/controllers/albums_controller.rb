class AlbumsController < ApplicationController
    # before_action require_login 
    def index
        @albums = Album.all
    end

    def show
        @album = Album.find_by(id: params[:id])
        if @album.nil?
            redirect_to albums_path
        end
    end

    def new
        @album = Album.new
    end

    def create
        @album = Album.build(album_params)
        @album.user = current_user
        if @album.save
            redirect_to album_path(@album)
        else
            render 'new'
        end
    end

    def edit
        @album = Album.find_by(:id => params[:id])
    end

    def update
        @album = Album.update(album_params)
        if @album.save
            redirect_to album_path(@album)
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
        end
    end    
    
    private
    def album_params
        params.require(:album).permit(:title, :date, :center, :creator, :description, :nasa_id, :href)
    end
end
