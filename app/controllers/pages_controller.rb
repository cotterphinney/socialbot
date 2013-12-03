class PagesController < ApplicationController
	before_filter :authenticate_admin!, :only => :admin

	def index
		messages = Message.where(:artificial => nil)
		@conversation = {}

		messages.each do |m|
			if m.parent_id?
				response = Message.find(m.parent_id).body
			else
				response = false
			end
			@conversation[m.body] = response
		end
	end

	def admin
	end
end
