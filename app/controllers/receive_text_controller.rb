class ReceiveTextController < ApplicationController
	def index
		text_body = params["Body"]
		text_number = params["From"]
	end
end
