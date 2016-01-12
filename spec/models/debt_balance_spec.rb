require 'rails_helper'

RSpec.describe DebtBalance, type: :model do
  it 'has a valid factory' do
    expect(FactoryGirl.build(:debt_balance)).to be_valid
  end

  it 'is invalid without a debt' do
    debt_balance = FactoryGirl.build(:debt_balance, debt: nil)
    expect(debt_balance).to_not be_valid
    expect(debt_balance.errors).to have_key(:debt)
  end

  it 'is invalid without a balance' do
    debt_balance = FactoryGirl.build(:debt_balance, balance: nil)
    expect(debt_balance).to_not be_valid
    expect(debt_balance.errors).to have_key(:balance)
  end

  it 'is invalid without a due_date' do
    debt_balance = FactoryGirl.build(:debt_balance, due_date: nil)
    expect(debt_balance).to_not be_valid
    expect(debt_balance.errors).to have_key(:due_date)
  end

  it 'has target_balance by default to be 0.0' do
    debt_balance = FactoryGirl.build(:debt_balance)
    expect(debt_balance.target_balance).to eq(0)
  end

  it 'has many spendings' do
    debt_balance = FactoryGirl.create(:debt_balance_with_spendings)
    expect(debt_balance.spendings.length).to eq(1)
  end
end
