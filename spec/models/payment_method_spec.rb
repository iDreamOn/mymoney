require 'rails_helper'

RSpec.describe PaymentMethod, type: :model do
  it 'has a valid factory' do
    expect(FactoryGirl.build(:payment_method)).to be_valid
  end

  it 'is invalid without name' do
    payment_method = FactoryGirl.build(:payment_method, name: nil)
    expect(payment_method).to_not be_valid
    expect(payment_method.errors).to have_key(:name)
  end

  it 'is invalid without description' do
    payment_method = FactoryGirl.build(:payment_method, description: nil)
    expect(payment_method).to_not be_valid
    expect(payment_method.errors).to have_key(:description)
  end

  it 'is unique per user' do
    pay1 = FactoryGirl.create(:payment_method)
    pay2 = FactoryGirl.build(:payment_method, name: pay1.name, user: pay1.user)
    expect(pay2).to_not be_valid
  end

  it 'has many spendings' do
    payment_method = FactoryGirl.create(:user_with_spendings)
    expect(payment_method.spendings.length).to eq(1)
  end

  it 'must belong to user' do
    payment_method = FactoryGirl.build(:payment_method, user: nil)
    expect(payment_method).to_not be_valid
    expect(payment_method.errors).to have_key(:user)
  end
end
