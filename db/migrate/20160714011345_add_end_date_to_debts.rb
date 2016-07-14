class AddEndDateToDebts < ActiveRecord::Migration
  def change
    add_column :debts, :end_date, :date, default: '9999-12-31'
  end
end
