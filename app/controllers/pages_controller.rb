class PagesController < ApplicationController
	before_filter :authenticate_admin!, :only => :admin

	def index
		@messages = Message.all
	end

	def admin
	end
end