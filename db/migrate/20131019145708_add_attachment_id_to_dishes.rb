class AddAttachmentIdToDishes < ActiveRecord::Migration
  def change
    execute("alter table dishes add column attachment_id int(11)")
  end
end
