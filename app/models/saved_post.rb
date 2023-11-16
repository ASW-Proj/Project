# app/models/saved_post.rb
class SavedPost < ApplicationRecord
  belongs_to :user
  belongs_to :post

  def self.exists_for_user_and_post?(user, post)
    where(user: user, post: post).exists?
  end
end
