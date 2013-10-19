class UpdateAvatarColumns < ActiveRecord::Migration
  def up
    add_column :attachments, :avatar_file_name, :string
    add_column :attachments, :avatar_content_type ,:string
    add_column :attachments, :avatar_file_size , :integer
    add_column :attachments, :avatar_update_at ,:datetime
  end

  def down
    remove_column :attachments, :avatar_file_name, :string
    remove_column :attachments, :avatar_content_type ,:string
    remove_column :attachments, :avatar_file_size , :integer
    remove_column :attachments, :avatar_update_at ,:datetime
  end
end
