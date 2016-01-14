require 'rails_helper'

RSpec.describe PaymentMethod, type: :model do
  it 'has a valid factory' do
    expect(FactoryGirl.build(:debt)).to be_valid
  end

  it 'is invalid without name' do
    debt = FactoryGirl.build(:debt, name: nil)
    expect(debt).to_not be_valid
    expect(debt.errors).to have_key(:name)
  end

  it 'has many spendings' do
    user = FactoryGirl.create(:user_with_spendings)
    expect(user.spendings.length).to eq(1)
  end

  it 'is unique per user' do
    random_id = 323
    user1 = FactoryGirl.build(:user, id: random_id)
    category1 = FactoryGirl.build(:category, user: user1)
    account1 = FactoryGirl.build(:account, user: user1)
    debt_1 = FactoryGirl.create(:debt, category: category1, account: account1)
    debt_2 = FactoryGirl.build(:debt, category: category1, account: account1, name: debt_1.name)

    expect(debt_2).to_not be_valid
  end

  it 'must belong to user' do
    debt = FactoryGirl.build(:debt, name: nil)
    expect(debt).to_not be_valid
    expect(debt.errors).to have_key(:name)
  end

  it 'is invalid without description' do
    debt = FactoryGirl.build(:debt, name: nil)
    expect(debt).to_not be_valid
    expect(debt.errors).to have_key(:name)
  end
end
