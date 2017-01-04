class AddPendingToSpendings < ActiveRecord::Migration
  def change
    add_column :spendings, :pending, :boolean
  end
end
