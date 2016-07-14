class ChangePaymentStartDateToStartDateInDebt < ActiveRecord::Migration
  def change
    rename_column :debts, :payment_start_date, :start_date
  end
end
