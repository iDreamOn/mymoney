class ChangePayScheduleToScheduleInIncomeSource < ActiveRecord::Migration
  def change
    rename_column :income_sources, :schedule, :schedule
  end
end
