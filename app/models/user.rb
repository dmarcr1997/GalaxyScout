class User < ApplicationRecord
    has_secure_password
    has_many :albums

    def self.admin
        admin = User.find_by(id: 1)
    end

end
