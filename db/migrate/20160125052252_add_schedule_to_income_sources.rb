class AddScheduleToIncomeSources < ActiveRecord::Migration
  def change
    add_reference :income_sources, :schedule, index: true, foreign_key: true
  end
end
