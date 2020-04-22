class Planet < ApplicationRecord
    validates :name, uniqueness: true
    has_many :album_planets
    has_many :albums, through: :album_planets
end
