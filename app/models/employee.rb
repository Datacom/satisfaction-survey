class Employee < ActiveRecord::Base
  has_many :daily_reports
  validates_presence_of :name, :message => "Must have a name"
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i

  def send_daily_reminder!
    report = self.daily_reports.create
    EmployeeMailer.daily_report(self, report).deliver!
  end
end
