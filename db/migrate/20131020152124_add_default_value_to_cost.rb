class AddDefaultValueToCost < ActiveRecord::Migration
  def change
    change_column :dishes, :cost, :float, :default => 0.0
  end
end
