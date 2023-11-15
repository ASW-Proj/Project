class Like < ApplicationRecord
  belongs_to :user
  belongs_to :comment, optional:true
  belongs_to :post, optional:true
  validates :like_type, inclusion: { in: [0, 1] }
end
