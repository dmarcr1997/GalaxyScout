class Planet < ApplicationRecord
    validates :name, presence: true
    validates :bio, presence: true
    validates :picture_src, presence: true
    validates :name, uniqueness: true

    has_many :album_planets
    has_many :albums, through: :album_planets
end
