class User < ApplicationRecord
    has_secure_password
    has_one :author
    has_many :comments
    has_many :albums, through: :comments

    def filter_user_albums(filter)
        sorted_albums = []
        if filter == 'Created'
            sorted_albums = self.created_albums
        elsif filter == 'Commented'
            sorted_albums = self.albums
        else
        end
        return sorted_albums.uniq(&:title)
    end

    def created_albums
        return self.author.albums
    end

    def all_albums 
        albums = []
        self.albums.each do |album|
            albums << album
        end
        self.author.albums.each do |album|
            albums << album
        end
        return albums.sort_by{|album| album.created_at}.uniq(&:title)
    end
end
