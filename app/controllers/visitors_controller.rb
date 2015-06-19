class VisitorsController < ApplicationController
	def index
		@employees = current_user.employees if current_user
		@todays_reports = DailyReport.on_day(Date.today)
	end
end
