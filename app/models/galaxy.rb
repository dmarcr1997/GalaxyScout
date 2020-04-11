class Galaxy < ApplicationRecord
    validates :name, presence: true
    validates :bio, presence: true
    validates :picture_src, presence: true
    validates :name, uniqueness: true

    has_many :album_galaxies
    has_many :albums, through: :album_galaxies
      
end
