class Album < ApplicationRecord
    validates :title, presence: true
    validates :date, presence: true
    validates :description, presence: true
    validates :href, presence: true
    
    belongs_to :user
    has_many :galaxies
    has_many :solar_systems
    has_many :planets

    def self.new_albums
        @api = Api.new
        @items = @api.fetch("")
        @all_items = @items["collection"]["items"]
        self.set_hash(@all_items)
    end

    def self.search_albums(search)
        @api = Api.new        
        @items = @api.fetch("search")
        @all_items = @items["collection"]["items"]
        self.set_hash(@all_items)
    end

    private
    def self.set_hash(items)
        admin = User.find_by(:username => 'admin')
        items.each do |i|  
            image_hash = {}
            image_hash["href"] = i["links"][0]["href"]
            image_hash["title"] = i["data"][0]["title"]
            image_hash["date"] = i["data"][0]["date_created"]
            image_hash["center"] = i["data"][0]["center"]
            image_hash["creator"] = i["data"][0]["secondary_creator"]
            image_hash["description"] = i["data"][0]["description"] 
            image_hash["nasa_id"] = i["data"][0]["nasa_id"]      
            album = Album.find_or_create_by(image_hash)
            album.user = admin
            album.save
        end
    end
end
