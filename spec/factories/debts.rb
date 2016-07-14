FactoryGirl.define do
  factory :debt do
    sub_category 'MyString'
    name { Faker::Company.name }
    is_asset false
    deleted_at nil
    fix_amount '9.99'
    schedule
    start_date '2015-12-27'
    autopay false
    category
    account

    factory :debt_with_debt_balances do
      transient do
        debt_balances_count 1
      end

      after(:create) do |debt, evaluator|
        create_list(:debt_balance, evaluator.debt_balances_count, debt: debt)
      end
    end
  end
end
