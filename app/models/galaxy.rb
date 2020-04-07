class Galaxy < ApplicationRecord
    validates :name, presence: true
    validates :bio, presence: true
    validates :picture_src, presence: true
    validates :name, uniqueness: true

    belongs_to :album
    has_many :solar_systems
    has_many :planets, through: :solar_systems
      
end
