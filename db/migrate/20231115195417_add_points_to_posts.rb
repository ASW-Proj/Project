class AddPointsToPosts < ActiveRecord::Migration[7.1]
  def change
    add_column :posts, :points, :integer, default: 0
  end
end
