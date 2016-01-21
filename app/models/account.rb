class Account < ActiveRecord::Base
  belongs_to :user
  has_many :income_sources
  has_many :account_balances
  has_many :debts
  has_many :debt_balances, through: :debts

  validates_presence_of :account_type, :name, :user
  validates_uniqueness_of :name, case_sensitive: false, scope: :user

  def to_s
    name
  end

  def owner
    user
  end
end
