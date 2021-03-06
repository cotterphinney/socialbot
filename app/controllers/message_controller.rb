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
    user = User.create!({  number: message.from_number,cold_text: true}) if @new_user
    message.user = user.reload
    
    previous_message = Message.where(
      to_number: message.from_number,
      from_number: message.to_number
    ).order("created_at desc").first
    
    message.parent = previous_message if previous_message
    
    message.save!
  end
end
