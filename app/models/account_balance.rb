class AccountBalance < ActiveRecord::Base
  belongs_to :account
  belongs_to :debt_balance

  attr_accessor :total_distribution

  validates_presence_of :account, :debt_balance, :amount, :buffer, :balance_date
  validates_uniqueness_of :balance_date, scope: :account

  def owner
    account.owner
  end

  def self.search_by_date(date)
    where(balance_date: date)
  end

  def to_s
    account.to_s
  end

  include Recommender
end
