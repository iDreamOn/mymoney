class RemovePayDayFromIncomeSources < ActiveRecord::Migration
  def change
    remove_column :income_sources, :pay_day, :string
  end
end
