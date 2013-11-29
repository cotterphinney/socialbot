class MessageController < ApplicationController
  skip_before_action :verify_authenticity_token
  
  def index
    render text: 'my name is mirrorbot'
  end
  
  def receive_text
    @received_body = params[:Body]
  end
end
