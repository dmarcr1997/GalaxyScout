class Planet < ApplicationRecord
    validates :name, presence: true
    validates :bio, presence: true
    validates :picture_src, presence: true
    validates :name, uniqueness: true

    belongs_to :album
    belongs_to :solar_system
end
