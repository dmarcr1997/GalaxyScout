class Album < ApplicationRecord
    def self.new_albums
        @api = Api.new
        items = @api.fetch("")
        @all_items = items["collection"]["items"]
        @all_items.each do |i|  
            image_hash = {}
            image_hash["href"] = i["links"][0]["href"]
            image_hash["title"] = i["data"][0]["title"]
            image_hash["date"] = i["data"][0]["date_created"]
            image_hash["center"] = i["data"][0]["center"]
            image_hash["creator"] = i["data"][0]["secondary_creator"]
            image_hash["description"] = i["data"][0]["description"] 
            image_hash["nasa_id"] = i["data"][0]["nasa_id"]      
            Album.create(image_hash)
        end
    end
end
