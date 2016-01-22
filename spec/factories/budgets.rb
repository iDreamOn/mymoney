FactoryGirl.define do
  factory :budget do
    budget_month { Faker::Date.between(5.days.ago, 3.days.ago) }
    amount { Faker::Commerce.price }
    category

    factory :budget_with_spendings do
      transient do
        spendings_count 2
      end

      after(:create) do |budget, evaluator|
        create_list(:spending, evaluator.spendings_count, budget: budget)
      end
    end
  end
end
