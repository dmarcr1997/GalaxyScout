class AlbumsController < ApplicationController
    before_action :require_login 

    def index
        @filters = ["Most Popular", "Newest", "Oldest"]
        if params.include?(:search)
            Album.search_albums(params[:search])
            admin = User.find_by(id: 1)
            @albums = admin.albums.uniq(&:title)
            if @albums.nil? || @albums.empty?
                flash[:alert] = "Sorry Nothing matches that search"
            end
        else
            @albums = Album.all.order('created_at DESC').uniq(&:title)
        end
    end

    def show
        @album = Album.find_by(id: params[:id])
        @comments = Comment.sort_time(@album.comments)
        @comment = Comment.new
        @galaxies = @album.galaxies.uniq(&:name)
        @space_objs = @album.space_objs.uniq(&:name)
        @planets = @album.planets.uniq(&:name)
        if @album.nil?
            redirect_to all_albums_path
        end
    end

    def new
        @album = Album.new
    end

    def create
        @album = Album.create(album_params)
        @album.user = current_user
        if @album.save
            tag_relation_conditional(params, @album)
        else
            render 'new'
        end
    end

    def edit
        @album = Album.find_by(:id => params[:id])
    end

    def update
        @album = Album.find_by(:id => params[:id])
        @album.update(album_params)
        if @album.save
            tag_relation_conditional(params, @album)
        else            
            render 'edit'
        end
    end

    def destroy
        # raise params.inspect
        @album = Album.find_by(:id => params[:id])
        if @album.user != current_user 
            redirect_to user_path(current_user)
        else
            @album.destroy
            redirect_to user_path(current_user)
        end
    end    
    
    private
    def album_params
        params.require(:album).permit(:title, :date, :center, :creator, :description, :nasa_id, :href, :options, :filter)
    end

end
