class ManagersController < ApplicationController
	before_filter :authenticate_admin

	def authenticate_admin
		render nothing:true , status: 403 unless current_user && current_user.admin?
	end

	def create
		user = User.new(email: params[:user][:email], password: params[:user][:password], name: params[:user][:name])
		if user.save!
			render  nothing: true, status: 200
		else
			render  nothing: true, status: 500
		end
	end

	def new 
		@manager = User.new
	end

	def index
		@managers = User.all
	end

end