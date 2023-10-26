class CreatePosts < ActiveRecord::Migration[7.1]
  def change
    create_table(:posts, force:true) do |t|
      t.string :title
      t.text :url
      t.text :body

      t.timestamps
    end
  end
end
