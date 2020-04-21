class Album < ApplicationRecord
    validates :title, presence: true
    validates :date, presence: true
    validates :description, presence: true
    validates :href, presence: true
    
    belongs_to :user
    has_many :comments
    has_many :users, through: :comments
    has_many :album_planets 
    has_many :album_space_objs
    has_many :album_galaxies
    has_many :galaxies, through: :album_galaxies
    has_many :space_objs, through: :album_space_objs
    has_many :planets, through: :album_planets

    def self.new_albums
        @api = Api.new
        @items = @api.fetch("")
        if !@items.nil?
            @all_items = @items["collection"]["items"]
            Album.set_hash(@all_items, false)
        end
    end

    def self.search_albums(search)
        @api = Api.new       
        @items = @api.fetch("#{search}")
        if !@items.nil?
            @all_items = @items["collection"]["items"]
            Album.set_hash(@all_items, true)
        end
    end

    private
    def self.set_hash(items, s)
        if s == true
            count = 0
        end
        admin = User.find_by(id: 1)
        items.each do |i|  
            image_hash = {}
            if i["links"].present?
                image_hash["href"] = i["links"][0]["href"] 
            end
            image_hash["title"] = i["data"][0]["title"] 
            image_hash["date"] = i["data"][0]["date_created"]  
            image_hash["center"] = i["data"][0]["center"] 
            image_hash["creator"] = i["data"][0]["secondary_creator"] 
            image_hash["description"] = i["data"][0]["description"] 
            image_hash["nasa_id"] = i["data"][0]["nasa_id"]
            album = Album.new(image_hash) 
            album.user = admin
            album.save    
            if s == true
                break if count == 20
                count +=1
            end
        end
    end
end
