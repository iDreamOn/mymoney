FactoryGirl.define do
  factory :account_balance do
    paid false
    amount '9.99'
    buffer '9.99'
    sequence(:balance_date) { |n| n.days.ago }
    account
    debt_balance
  end
end
