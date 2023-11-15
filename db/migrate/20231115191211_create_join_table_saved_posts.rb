class CreateJoinTableSavedPosts < ActiveRecord::Migration[7.1]
  def change
    create_join_table :users, :posts, table_name: :saved_posts do |t|
      t.index :user_id
      t.index :post_id
    end
  end
end