class MessageController < ApplicationController
  def index
    render text: 'my name is mirrorbot'
  end
  
  def receive_text
    @received_body = params[:Body]
  end
end
