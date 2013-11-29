class ReceiveTextController < ApplicationController
	def index
		m = Message.new
		m.number = params["From"]
		m.body = params["Body"]
		m.save
	end
end
