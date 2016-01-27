require 'rails_helper'

RSpec.describe AccountBalance, type: :model do
  it 'has a valid factory' do
    expect(FactoryGirl.build(:account_balance)).to be_valid
  end

  it 'must have an owner' do
    account_balance = FactoryGirl.build(:account_balance)
    expect(account_balance.owner).to_not be_nil
  end

  it 'must belong to an account' do
    account_balance = FactoryGirl.build(:account_balance, account: nil)
    expect(account_balance).to_not be_valid
    expect(account_balance.errors).to have_key(:account)
  end

  it 'must have a debt balance (leftover)' do
    account_balance = FactoryGirl.build(:account_balance, debt_balance: nil)
    expect(account_balance).to_not be_valid
    expect(account_balance.errors).to have_key(:debt_balance)
  end

  it 'is invalid without an amount' do
    account_balance = FactoryGirl.build(:account_balance, amount: nil)
    expect(account_balance).to_not be_valid
    expect(account_balance.errors).to have_key(:amount)
  end

  it 'is invalid without a buffer' do
    account_balance = FactoryGirl.build(:account_balance, buffer: nil)
    expect(account_balance).to_not be_valid
    expect(account_balance.errors).to have_key(:buffer)
  end

  it 'is invalid without a balance date' do
    account_balance = FactoryGirl.build(:account_balance, balance_date: nil)
    expect(account_balance).to_not be_valid
    expect(account_balance.errors).to have_key(:balance_date)
  end

  it '#to_s returns the account name' do
    account = FactoryGirl.build(:account)
    account_balance = FactoryGirl.build(:account_balance, account: account)
    expect(account_balance.to_s).to eq(account.name)
  end

  describe 'filter by date' do
    before :each do
      @smith = FactoryGirl.create(:account_balance, balance_date: '2016-02-01')
      @jones = FactoryGirl.create(:account_balance, balance_date: '2016-01-01')
      @johnson = FactoryGirl.create(:account_balance, balance_date: '2016-01-01')
    end

    context 'matching dates' do
      it 'returns an array of results that match' do
        expect(AccountBalance.search_by_date('2016-01-01')).to match_array([@johnson, @jones])
      end
    end

    context 'non-matching dates' do
      it "does not return account_balances that don't match the provided date" do
        expect(AccountBalance.search_by_date('2016-02-01')).to match_array([@smith])
      end
    end
  end
end
