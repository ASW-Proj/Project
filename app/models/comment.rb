class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user
  belongs_to :community
  has_many :saved_comments, dependent: :destroy
  has_many :savers, through: :saved_comments, source: :user
end
