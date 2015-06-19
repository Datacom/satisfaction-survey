class CreateDailyReports < ActiveRecord::Migration
  def change
    create_table :daily_reports do |t|
      t.integer :employee_id
      t.integer :score
      t.text :comment

      t.timestamps null: false
    end
  end
end
