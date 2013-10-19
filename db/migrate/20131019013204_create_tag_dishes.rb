class CreateTagDishes < ActiveRecord::Migration
  def change
    create_table :tag_dishes do |t|
      t.integer :tag_id
      t.integer :dish_id

      t.timestamps
    end
  end
end
