FactoryGirl.define do
  factory :budget do
    budget_month '2015-12-26'
    amount '9.99'
    category

    factory :budget_with_spendings do
      transient do
        spendings_count 2
      end

      after(:create) do |param1, evaluator|
        create_list(:spending, evaluator.spendings_count, budget: param1)
      end
    end
  end
end
