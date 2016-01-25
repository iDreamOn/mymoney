class ChangeScheduleToText < ActiveRecord::Migration
  def change
    change_column :income_sources, :schedule, :text
  end
end
