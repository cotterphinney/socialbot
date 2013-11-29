class Message < ActiveRecord::Base
	belongs_to :user
  
  belongs_to :parent, :class_name => "Message", :inverse_of => :response
  belongs_to :response, :class_name => "Message", :inverse_of => :parent
  
  after_save :update_parent
  
  def update_parent
    Message.where(id: self.parent_id).update_all(response_id: self.id)
  end
end
