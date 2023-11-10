class RenameCommunityId < ActiveRecord::Migration[7.1]
  def change
    rename_column :communities, :c_id, :identifier
  end
end
