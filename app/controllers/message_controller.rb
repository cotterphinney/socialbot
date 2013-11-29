class MessageController < ApplicationController
  skip_before_action :verify_authenticity_token
  
  def index
    render text: 'my name is mirrorbot'
  end
  
  def receive_text
    message = Message.new({
      from_number: params[:From],
      to_number: params[:To],
      body: params[:Body],
      sid: params[:MessageSid],
      account_sid: params[:AccountSid],
      artificial: false
    })
    
    user = User.where({number: message.from_number}).first
    @new_user = user.nil?
    User.create!({  number: message.from_number,cold_text: true}) if @new_user
    message.user = user.reload
    
    previous_message = Message.where(
      to_number: message.from_number,
      from_number: message.to_number
    ).order("created_at desc").first
    
    message.parent = previous_message if previous_message
    
    message.save!
  end

  def send_response
    to_number = params[:to_number]
    twilio_sid = ENV['twilio_sid']
    twilio_token = ENV['twilio_token']
    twilio_phone_number = ENV['twilio_phone_number']
    @twilio_client = Twilio::REST::Client.new twilio_sid, twilio_token

    message_body = ""

    @twilio_client.account.sms.messages.create(
      :from => "+1#{twilio_phone_number}",
      :to => to_number,
      :body => message_body
    )
  end
end
