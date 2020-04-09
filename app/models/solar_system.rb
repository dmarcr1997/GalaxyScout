class SolarSystem < ApplicationRecord
    validates :name, presence: true
    validates :bio, presence: true
    validates :picture_src, presence: true
    validates :name, uniqueness: true

    has_many :album_solarsystems
    has_many :albums, through: :album_solarsystems
end
