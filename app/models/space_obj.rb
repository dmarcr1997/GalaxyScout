class SpaceObj < ApplicationRecord
    validates :name, presence: true
    validates :picture_src, presence: true
    validates :name, uniqueness: true

    has_many :album_space_objs
    has_many :albums, through: :album_space_objs
end
