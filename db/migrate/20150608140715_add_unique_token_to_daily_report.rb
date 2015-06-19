class AddUniqueTokenToDailyReport < ActiveRecord::Migration
  def change
    add_column :daily_reports, :access_token, :string
  end
end
