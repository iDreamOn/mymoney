class AddScheduleToDebts < ActiveRecord::Migration
  def change
    add_reference :debts, :schedule, index: true, foreign_key: true
  end
end
