class EmployeeMailer < ApplicationMailer
  layout nil
	def daily_report(employee, report)
    @employee = employee
    @report = report
    mail to: employee.email, subject: 'Please check in, 263 Satisfaction'
	end
end
