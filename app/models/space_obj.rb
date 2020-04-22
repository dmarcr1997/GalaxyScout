class SpaceObj < ApplicationRecord
    validates :name, uniqueness: true

    has_many :album_space_objs
    has_many :albums, through: :album_space_objs
end
