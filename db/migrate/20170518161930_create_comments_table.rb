class CreateCommentsTable < ActiveRecord::Migration[5.1]
  def change
	  create_table :comments do |t|
      t.integer :user_id
        t.integer :awact_id
      t.string :body
	  end
  end
end
