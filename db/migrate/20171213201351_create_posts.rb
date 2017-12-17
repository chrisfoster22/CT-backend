class CreatePosts < ActiveRecord::Migration[5.1]
  def change
	  create_table :posts do |t|
      t.string :title
      t.string :category
      t.text :description
      t.integer :awact_id
      t.integer :user_id
	  end
  end
end
