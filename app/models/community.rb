class Community < ApplicationRecord
    has_one_attached :avatar
    has_one_attached :banner
    validates :c_id, presence: true
    validates_uniqueness_of :c_id
    has_many :posts
end
