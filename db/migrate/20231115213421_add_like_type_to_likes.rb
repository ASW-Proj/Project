class AddLikeTypeToLikes < ActiveRecord::Migration[7.1]
  def change
    add_column :likes, :like_type, :integer
  end
end
