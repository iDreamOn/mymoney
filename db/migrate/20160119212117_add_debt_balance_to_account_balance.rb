class AddDebtBalanceToAccountBalance < ActiveRecord::Migration
  def change
    add_reference :account_balances, :debt_balance, index: true, foreign_key: true
  end
end
