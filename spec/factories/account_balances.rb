FactoryGirl.define do
  factory :account_balance do
    paid false
    amount '9.99'
    buffer '9.99'
    balance_date { Faker::Date.between(10.days.ago, Date.today) }
    account
    debt_balance
  end
end
