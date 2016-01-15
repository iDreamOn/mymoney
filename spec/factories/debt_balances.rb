FactoryGirl.define do
  factory :debt_balance do
    balance { Faker::Commerce.price }
    payment_start_date { Faker::Date.between(5.days.ago, 3.days.ago) }
    due_date { Faker::Date.between(2.days.ago, Date.today) }
    # target_balance { Faker::Commerce.price }
    debt

    factory :debt_balance_with_spendings do
      transient do
        spendings_count 1
      end

      after(:create) do |param1, evaluator|
        create_list(:spending, evaluator.spendings_count, debt_balance: param1)
      end
    end
  end
end
