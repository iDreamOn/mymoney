class RemoveScheduleFromIncomeSources < ActiveRecord::Migration
  def change
    remove_column :income_sources, :schedule, :text
  end
end
