# app/models/saved_comment.rb
class SavedComment < ApplicationRecord
  belongs_to :user
  belongs_to :comment
end
