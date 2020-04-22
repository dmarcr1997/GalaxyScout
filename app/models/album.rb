class Album < ApplicationRecord
    validates :title, presence: true
    validates :date, presence: true
    validates :description, presence: true
    validates :href, presence: true
    
    belongs_to :author
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
            Api.new_from_hash(@all_items, false)
        end
    end

    def self.search_albums(search)
        @api = Api.new       
        @items = @api.fetch("#{search}")
        if !@items.nil?
            @all_items = @items["collection"]["items"]
            Api.new_from_hash(@all_items, true)
        end
    end

    def self.filter_albums(filter)
        if filter[:option] == 'Most Popular'
           sorted_albums = Album.most_popular
       elsif filter[:option] == 'Newest'
           sorted_albums = Album.newest
       elsif filter[:option] == 'Oldest'
           sorted_albums = Album.oldest
       else
           return Album.all
       end
       return sorted_albums
   end

   def self.most_popular
        return Album.all.order('comments_count DESC')
   end

   def self.newest
        return Album.all.order('created_at DESC')
   end

   def self.oldest
        return Album.all.order('created_at ASC')
   end

   def galaxies_attributes=(galaxies_attributes)
    attr_status = check_if_attr_empty(galaxies_attributes)
    if attr_status == true
      galaxies_attributes.values.each do |galaxies_attribute|
        galaxy = Galaxy.find_or_create_by(galaxies_attribute)
        self.galaxies << galaxy
      end
    end
  end

  def planets_attributes=(planets_attributes)
    attr_status = check_if_attr_empty(planets_attributes)
    if attr_status == true
      planets_attributes.values.each do |planets_attribute|
        planet = Planet.find_or_create_by(planets_attribute)
        self.planets << planet
      end
    end
  end

  def space_objs_attributes=(space_objs_attributes)
    attr_status = check_if_attr_empty(space_objs_attributes)
    if attr_status == true
      space_objs_attributes.values.each do |space_objs_attribute|
        space_obj = SpaceObj.find_or_create_by(space_objs_attribute)
        self.space_objs << space_obj
      end
    end
  end

  def check_if_attr_empty(attributes)
    return true if attributes[:name] != "" && attributes[:picture_src]
  end
end
