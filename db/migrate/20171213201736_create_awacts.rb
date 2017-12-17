class CreateAwacts < ActiveRecord::Migration[5.1]
  def change
    create_table :awacts do |t|
      t.integer :creator_id
      t.integer :participant_id
      t.string :title
      t.string :body
      t.datetime :event_time
      t.string :location
      t.boolean :in_progress
	  end
  end
end
