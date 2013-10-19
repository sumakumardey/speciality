class Attachment < ActiveRecord::Base
  attr_accessible :avatar
  attr_accessor :avatar_file_name
  
  belongs_to :attachable, :polymorphic => true
  has_attached_file :avatar,
  :storage => :database,
  :styles => { :thumb => "75x75!", :small => "250x300!" },
  :url => '/:class/:id/:attachment?style=:style'
  default_scope select_without_file_columns_for(:avatar)
end
