class AlbumRelation < ApplicationRecord
    belongs_to :album
    belongs_to :galaxy
    belongs_to :solar_system
    belongs_to :planet
end
