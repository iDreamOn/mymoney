class DropAccountBalanceDistributions < ActiveRecord::Migration
  def change
    drop_table :account_balance_distributions if ActiveRecord::Base.connection.table_exists? 'account_balance_distributions'
    remove_foreign_key :account_balances, :debt
    remove_index :account_balances, :debt_id
    remove_column :account_balances, :debt_id
  end
end
