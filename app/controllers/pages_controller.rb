class PagesController < ApplicationController
	before_filter :authenticate_admin!, :only => :admin

	def index
		render text: "index"
	end

	def admin
	end
end
