class AddUnitIdToEmployee < ActiveRecord::Migration
  def change
    add_column :employees, :unit, :string
  end
end
