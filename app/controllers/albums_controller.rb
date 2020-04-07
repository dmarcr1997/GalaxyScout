class AlbumsController < ApplicationController
    def index
        Album.new_albums
        @albums = Album.all
    end
end
