class PagesController < ApplicationController
	before_filter :authenticate_admin!, :only => :admin

	def index
		@messages = Message.where(:artificial => false)
		@conversation = {}

		@messages.each do |m|
			if m.parent_id
				response = Message.where(id: m.parent_id).first
			else
				response = nil
			end

			if response
				@conversation[m.body] = response.body
			else
				@conversation[m.body] = nil
			end
		end
	end

	def admin
	end
end
