class Community < ApplicationRecord
    has_one_attached :avatar
    has_one_attached :banner
    validates :identifier, presence: true, uniqueness: true, :length => {
        :minimum => 1,
        :too_short => "must have at least %{count} characters",
    }
    validates :name, presence: false, uniqueness: true, allow_blank: true, :length => {
        :minimum => 2,
        :maximum => 40,
        :too_short => "must have at least %{count} characters",
        :too_long  => "must have at most %{count} characters",
    }
    has_many :posts, dependent: :restrict_with_exception
    has_many :comments, dependent: :restrict_with_exception
    has_many :subscriptions, dependent: :destroy
end
