class CreateAttachments < ActiveRecord::Migration
  def up
    create_table :attachments do |t|
      t.integer :attachable_id
      t.string  :attachable_type
      t.timestamps
    end
    execute 'ALTER TABLE attachments ADD COLUMN avatar_file LONGBLOB'
    execute 'ALTER TABLE attachments ADD COLUMN avatar_small_file LONGBLOB'
    execute 'ALTER TABLE attachments ADD COLUMN avatar_thumb_file LONGBLOB'
  end
  def down
  end

end

