class AlbumsController < ApplicationController
    before_action :require_login 

    def index
        @albums = Album.all.order('created_at DESC')

    end

    def show
        @album = Album.find_by(id: params[:id])
        if @album.nil?
            redirect_to albums_path
        end
    end

    def new
        @album = Album.new
        @categories = ["Galaxy", "Solar System", "Planet", "Other"]
    end

    def create
        @album = Album.new(album_params)
        @album.user = current_user
        if @album.save
            if !@album.options.include?("Other")
                session[:album_id] = @album.id
                set_relations(params)
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
        params.require(:album).permit(:title, :date, :center, :creator, :description, :nasa_id, :href, :options)
    end
end
