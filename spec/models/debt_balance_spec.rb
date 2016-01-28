require 'rails_helper'

RSpec.describe DebtBalance, type: :model do
  it 'has a valid factory' do
    expect(FactoryGirl.build(:debt_balance)).to be_valid
  end

  context 'is invalid when' do
    it 'debt is emtpy' do
      debt_balance = FactoryGirl.build(:debt_balance, debt: nil)
      expect(debt_balance).to_not be_valid
      expect(debt_balance.errors).to have_key(:debt)
    end

    it 'balance is empty' do
      debt_balance = FactoryGirl.build(:debt_balance, balance: nil)
      expect(debt_balance).to_not be_valid
      expect(debt_balance.errors).to have_key(:balance)
    end

    it 'due date is empty' do
      debt_balance = FactoryGirl.build(:debt_balance, due_date: nil)
      expect(debt_balance).to_not be_valid
      expect(debt_balance.errors).to have_key(:due_date)
    end

    it 'payment start date is before a previous due date' do
      debt = FactoryGirl.create(:debt)
      FactoryGirl.create(:debt_balance, debt: debt, payment_start_date: 2.months.ago, due_date: 2.days.ago)
      current_debt_balance = FactoryGirl.build(:debt_balance, debt: debt, payment_start_date: 4.months.ago, due_date: Time.now)
      expect(current_debt_balance).to_not be_valid
      expect(current_debt_balance.errors).to have_key(:payment_start_date)
    end

    context 'debt balances overlap' do
      it 'payment start date is between start and due date of a previous debt balance' do
        debt = FactoryGirl.create(:debt)
        FactoryGirl.create(:debt_balance, debt: debt, payment_start_date: 2.months.ago, due_date: 2.days.ago)
        current_debt_balance = FactoryGirl.build(:debt_balance, debt: debt, payment_start_date: 1.months.ago, due_date: Time.now)
        expect(current_debt_balance).to_not be_valid
        expect(current_debt_balance.errors).to have_key(:goal)
      end

      it 'due date is between start and due date of a previous debt balance' do
        debt = FactoryGirl.create(:debt)
        FactoryGirl.create(:debt_balance, debt: debt, payment_start_date: 2.months.ago, due_date: 2.days.ago)
        current_debt_balance = FactoryGirl.build(:debt_balance, debt: debt, payment_start_date: 1.days.ago, due_date: 10.days.ago)
        expect(current_debt_balance).to_not be_valid
        expect(current_debt_balance.errors).to have_key(:goal)
      end
    end

    it 'payment start date is after its own due date' do
      debt = FactoryGirl.create(:debt)
      debt_balance = FactoryGirl.build(:debt_balance, debt: debt, payment_start_date: Time.now, due_date: 1.days.ago)
      expect(debt_balance).to_not be_valid
      expect(debt_balance.errors).to have_key(:payment_start_date)
    end
  end

  it 'has target balance by default to be 0.0' do
    debt_balance = FactoryGirl.build(:debt_balance)
    expect(debt_balance.target_balance).to eq(0)
  end

  it 'has many spendings' do
    debt_balance = FactoryGirl.create(:debt_balance_with_spendings)
    expect(debt_balance.spendings.length).to eq(1)
  end
end
