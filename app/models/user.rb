class User < ApplicationRecord
    has_secure_password

    has_many :surveys
    has_many :responses

    enum role: { respondent: 0, coordinator: 1 }

    validates :email, presence: true, uniqueness: true
    validates :name, presence: true
    validates :password, presence: true, length: { minimum: 6 }
end
