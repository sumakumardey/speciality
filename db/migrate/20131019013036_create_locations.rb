class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.float :longitude
      t.float :latitude
      t.string :street
      t.string :city
      t.string :state
      t.string :country

      t.timestamps
    end
  end
end
