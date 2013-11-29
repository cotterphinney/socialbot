class Message < ActiveRecord::Base
	belongs_to :user
  
  belongs_to :parent, :class_name => "Message"
  has_many :responses, :foreign_key => "parent_id", :class_name => "Message"
end
