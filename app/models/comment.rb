class Comment < ApplicationRecord
  validates :body, presence: true, :length => {
        :minimum => 4,
        :maximum => 255,
        :too_short => "must have at least %{count} characters",
        :too_long  => "must have at most %{count} characters",
    }
  belongs_to :user
  belongs_to :post, counter_cache: true
  belongs_to :community
  has_many :likes, dependent: :destroy

  has_many :replies, class_name: 'Comment', foreign_key: 'parent_id', dependent: :destroy
  belongs_to :parent, class_name: 'Comment', optional: true

  has_many :saved_comments, dependent: :destroy
  has_many :savers, through: :saved_comments, source: :user

end
