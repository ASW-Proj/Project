class Community < ApplicationRecord
    has_one_attached :avatar
    has_one_attached :banner
    validates :c_id, presence: true
    has_many :posts
end
