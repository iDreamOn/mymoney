class Account < ActiveRecord::Base
  belongs_to :user
  has_many :income_sources
  has_many :account_balances
  has_many :debts
  has_many :debt_balances, through: :debts

  def to_s
    name
  end

  def owner
    user
  end
end
