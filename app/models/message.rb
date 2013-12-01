ACCOUNT_SID = 'ACfc93658ca7686387e14b7ebe65b2c5ea'
AUTH_TOKEN = '9831d388ae82dd36f31945db50871d28'

class Message < ActiveRecord::Base
	belongs_to :user
  
  belongs_to :parent, :class_name => "Message"
  has_many :responses, :foreign_key => "parent_id", :class_name => "Message"
  
  def send!
    client = Twilio::REST::Client.new ACCOUNT_SID, AUTH_TOKEN
    client.account.messages.create(
      :from => from_number,
      :to => to_number,
      :body => body
    )
  end
end
