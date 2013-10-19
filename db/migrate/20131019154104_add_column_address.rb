class AddColumnAddress < ActiveRecord::Migration
  def up
  	add_column :locations, :address, :string
  end

  def down
  	remove_column :locations, :address, :string
  end
end
