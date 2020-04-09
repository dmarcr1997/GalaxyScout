class SolarSystem < ApplicationRecord
    validates :name, presence: true
    validates :bio, presence: true
    validates :picture_src, presence: true
    validates :name, uniqueness: true

    has_many :album_relations
    has_many :albums, through: :album_relations
    belongs_to :galaxy
    has_many :planets
end
