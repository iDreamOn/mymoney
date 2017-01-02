require 'rails_helper'

RSpec.describe Budget, type: :model do
  it 'has a valid factory' do
    expect(FactoryGirl.build(:budget)).to be_valid
  end

  it 'is invalid without category' do
    budget = FactoryGirl.build(:debt, category: nil)
    expect(budget).to_not be_valid
    expect(budget.errors).to have_key(:category)
  end

  it 'is invalid without an amount' do
    budget = FactoryGirl.build(:budget, amount: nil)
    expect(budget).to_not be_valid
    expect(budget.errors).to have_key(:amount)
  end
  it 'is invalid without budget month' do
    budget = FactoryGirl.build(:budget, budget_month: nil)
    expect(budget).to_not be_valid
    expect(budget.errors).to have_key(:budget_month)
  end

  it 'can have many spendings' do
    budget = FactoryGirl.create(:budget_with_spendings)
    expect(budget.spendings.length).to eq(2)
  end

  it 'is unique per category per month' do
    budget1 = FactoryGirl.create(:budget)
    budget2 = FactoryGirl.build(:budget, category: budget1.category, budget_month: budget1.budget_month)
    expect(budget2).to_not be_valid
  end

  it 'adds the right amount' do
    budget = FactoryGirl.create(:budget)
    amount = budget.amount
    budget.add(50)
    expect(budget.amount).to eq(amount+50)
  end
end
