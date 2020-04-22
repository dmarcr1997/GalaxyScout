class Galaxy < ApplicationRecord
    validates :name, uniqueness: true

    has_many :album_galaxies
    has_many :albums, through: :album_galaxies
      
end
