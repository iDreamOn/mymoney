require 'rails_helper'

RSpec.describe Category, type: :model do
  it 'has a valid factory' do
    expect(FactoryGirl.build(:category)).to be_valid
  end

  it 'must have a name' do
    category = FactoryGirl.build(:category, name: nil)
    expect(category).to_not be_valid
    expect(category.errors).to have_key(:name)
  end

  it 'must have a description' do
    category = FactoryGirl.build(:category, description: nil)
    expect(category).to_not be_valid
    expect(category.errors).to have_key(:description)
  end

  it 'must be unique per user' do
    cat1 = FactoryGirl.create(:category)
    cat2 = FactoryGirl.build(:category, user: cat1.user)
    expect(cat2).to_not be_valid
  end

  it 'must belong to user' do
    category = FactoryGirl.build(:category, user: nil)
    expect(category).to_not be_valid
    expect(category.errors).to have_key(:user)
  end

  it 'can has many debts' do
    category = FactoryGirl.create(:category_with_debts)
    expect(category.debts.length).to eq(2)
  end

  it 'can has many budgets' do
    category = FactoryGirl.create(:category_with_budgets)
    expect(category.budgets.length).to eq(2)
  end

end


