class User < ApplicationRecord
    has_secure_password
    has_many :albums
    has_many :comments
    has_many :albums, through: :comments
end
