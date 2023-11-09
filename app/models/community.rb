class Community < ApplicationRecord
    has_one_attached :avatar
    has_one_attached :banner
    validates :c_id, presence: true, uniqueness: true
    has_many :posts, dependent: :restrict_with_exception
end
