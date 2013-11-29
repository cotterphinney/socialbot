class MessageController < ApplicationController
  def index
    render text: 'my name is mirrorbot'
  end
  
  def receive_text
  end
end
