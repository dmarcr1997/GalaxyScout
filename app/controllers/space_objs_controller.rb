class SpaceObjsController < ApplicationController
    before_action :require_login
    def new
        @space_obj = SpaceObj.new
    end

    def create
        @album = Album.find_by(id: session[:album_id])
        @space_obj = SpaceObj.find_or_create_by(space_objs_params)
        if @space_obj.save
            @album.space_objs << @space_obj
            @album.save
           session.delete :album_id
           redirect_to album_path(@album)
        else
            render 'new'
        end
    end

    private
    def space_objs_params
        params.require(:space_obj).permit(:name, :bio, :picture_src, :size)
    end
    
end
