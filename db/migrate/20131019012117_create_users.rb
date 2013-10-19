class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :twitter_id
      t.string :facebook_id
      t.integer :location_id
      t.integer :no_of_ratings
      t.integer :no_of_reviews

      t.timestamps
    end
  end
end
