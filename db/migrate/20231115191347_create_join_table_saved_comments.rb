class CreateJoinTableSavedComments < ActiveRecord::Migration[7.1]
  def change
    create_join_table :users, :comments, table_name: :saved_comments do |t|
      t.index :user_id
      t.index :comment_id
    end
  end
end