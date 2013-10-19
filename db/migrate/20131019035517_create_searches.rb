class CreateSearches < ActiveRecord::Migration
  def change
    create_table :searches do |t|
      t.string :query
      t.integer :item_id
      t.datetime :searched_at
      t.datetime :converted_at
    end
  end
end
