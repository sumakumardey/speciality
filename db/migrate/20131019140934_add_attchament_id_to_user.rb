class AddAttchamentIdToUser < ActiveRecord::Migration
  def up
    execute("alter table users add column attachment_id int(11)")
  end
end
