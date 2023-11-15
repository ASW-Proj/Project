class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  belongs_to :community

  has_many :replies, class_name: 'Comment', foreign_key: 'parent_id'
  belongs_to :parent, class_name: 'Comment', optional: true
  
  has_many :saved_comments, dependent: :destroy
  has_many :savers, through: :saved_comments, source: :user

end
