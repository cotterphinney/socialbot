class PagesController < ApplicationController
	before_filter :authenticate_admin!, :only => :admin

	def index
		@messages = Message.limit(200)
	end

	def admin
	end
end
