class CreateCommunities < ActiveRecord::Migration[7.1]
  def change
    create_table :communities do |t|
      t.text :c_id
      t.string :name

      t.timestamps
    end
  end
end
