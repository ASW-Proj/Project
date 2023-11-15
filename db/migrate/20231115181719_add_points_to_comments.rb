class AddPointsToComments < ActiveRecord::Migration[7.1]
  def change
    add_column :comments, :points, :integer, default: 0 
  end
end
