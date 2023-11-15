class AddPointsToComments < ActiveRecord::Migration[7.1]
  def change
    add_column :comments, :points, :integer
  end
end
