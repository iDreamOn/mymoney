require 'rails_helper'
RSpec.describe Account, type: :model do
  it 'has a valid factory' do
    expect(FactoryGirl.build(:debt)).to be_valid
  end

  it 'is invalid without name' do
    account = FactoryGirl.build(:account, name: nil)
    expect(account).to_not be_valid
    expect(account.errors).to have_key(:name)
  end

  it 'is invalid without a user' do
    account = FactoryGirl.build(:account, user: nil)
    expect(account).to_not be_valid
    expect(account.errors).to have_key(:user)
  end

  it 'is invalid without an account type' do
    account = FactoryGirl.build(:account, account_type: nil)
    expect(account).to_not be_valid
    expect(account.errors).to have_key(:account_type)
  end
  it 'must be unique per user' do
    user1 = FactoryGirl.create(:user)
    account1 = FactoryGirl.create(:account, user: user1)
    account2 = FactoryGirl.build(:account, user: user1, name: account1.name)
    expect(account2).to_not be_valid
  end

  it 'has many debts' do
    account = FactoryGirl.create(:account_with_debts)
    expect(account.debts.length).to eq(2)
  end

  it 'has many income_sources' do
    account = FactoryGirl.create(:account_with_income_sources)
    expect(account.income_sources.length).to eq(1)
  end

  it 'has many account_balances' do
    account = FactoryGirl.create(:account_with_account_balances)
    expect(account.account_balances.length).to eq(2)
  end

  it 'has many debt_balances' do
    account = FactoryGirl.create(:account_with_debt_balances)
    expect(account.debt_balances.length).to eq(1)
  end
end
