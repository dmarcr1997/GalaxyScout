class Api
    def fetch(search)
        if search.empty?
            url = "https://images-api.nasa.gov/search?q=pictures"
        else
            url = "https://images-api.nasa.gov/search?q=#{search}"
        end
        response = HTTParty.get(url)
        response.parsed_response
    end  

    def self.new_from_hash(items, s)
        if s == true
            count = 0
        end
        admin = Author.find_by(id: 1)
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
            album.author_id = admin.id
            album.save    
            if s == true
                break if count == 20
                count +=1
            end
        end
    end
end
