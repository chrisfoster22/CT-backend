class AddCompletedToAwacts < ActiveRecord::Migration[5.1]
  def change
    add_column :awacts, :completed, :boolean
  end
end
