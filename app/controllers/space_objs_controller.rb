class SpaceObjsController < ApplicationController
    before_action :require_login
    def new
        @album = Album.find_by(id: params[:album_id])
        @space_obj = SpaceObj.new
    end

    def index
        if params[:album_id]
            @album = Album.find_by(id: params[:album_id])
            if @album.nil?
                redirect_to albums_path, alert: "Cannot find that album"
            else
                @space_objs = @album.space_objs
            end
        else
            redirect_to albums_path
        end
    end

    def create
        @album = Album.find_by(id: params[:space_obj][:album_id])
        if @album.nil?
            redirect_to albums_path, alert: "Album not found"
        end
        @space_obj = SpaceObj.find_or_create_by(space_objs_params)
        if @space_obj.save
           @album.space_objs << @space_obj
           @album.save
           redirect_to album_path(@album)
        else
            render 'new'
        end
    end

    def show
        @space_obj = SpaceObj.find_by(:id => params[:id])
    end

    private
    def space_objs_params
        params.require(:space_obj).permit(:name, :bio, :picture_src, :size)
    end
    
end
