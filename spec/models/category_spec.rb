require 'rails_helper'

RSpec.describe Category, type: :model do
  it 'has a valid factory' do
    expect(FactoryGirl.build(:category)).to be_valid
  end

  it 'is invalid without name' do
    category = FactoryGirl.build(:category, name: nil)
    expect(category).to_not be_valid
    expect(category.errors).to have_key(:name)
  end

  it 'is invalid without description' do
    category = FactoryGirl.build(:category, description: nil)
    expect(category).to_not be_valid
    expect(category.errors).to have_key(:description)
  end

  it 'is unique per user' do
    random_id = 323
    user1 = FactoryGirl.build(:user, id: random_id)
    description1 = FactoryGirl.build(:description, user: user1)
    pay1 = FactoryGirl.create(:category, description: description1)
    pay2 = FactoryGirl.build(:category, description: description1, name: pay1.name)
    expect(pay2).to_not be_valid
  end

  it 'must belong to user' do
    category = FactoryGirl.build(:category, user: nil)
    expect(category).to_not be_valid
    expect(category.errors).to have_key(:user)
  end

  it 'has many spendings' do
    category = FactoryGirl.create(:user_with_spendings)
    expect(category.spendings.length).to eq(1)
  end

end



#spending Ex: must belong to
	it 'budget is empty' do
      spending = FactoryGirl.build(:spending, budget: nil)
      expect(spending).to_not be_valid
      expect(spending.errors).to have_key(:budget)
    end 