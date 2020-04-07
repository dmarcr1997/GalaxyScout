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

end
