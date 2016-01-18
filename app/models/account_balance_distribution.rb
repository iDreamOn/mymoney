class AccountBalanceDistribution < ActiveRecord::Base
  belongs_to :account_balance
  delegate :balance_date, to: :account_balance, prefix: true, allow_nil: true

  belongs_to :debt

  def owner
    account_balance.owner
  end
end
