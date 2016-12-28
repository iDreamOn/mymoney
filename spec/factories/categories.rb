require 'faker'

FactoryGirl.define do
  factory :category do
    name { Faker::Commerce.product_name }
    description { Faker::Commerce.department(5) }
    user

    factory :category_with_debts do
      transient do
        debts_count 2
      end

      after(:create) do |category, evaluator|
        create_list(:debt, evaluator.debts_count, category: category)
      end
    end

    factory :category_with_debts_and_budgets do
      transient do
        debts_count 1
      end

      after(:create) do |category, evaluator|
        create_list(:debt, evaluator.debts_count, category: category)
        create_list(:budget, evaluator.debts_count, category: category)
      end
    end

    factory :category_with_budgets do
      transient do
        budgets_count 1
      end

      after(:create) do |category, evaluator|
        create_list(:budget, evaluator.budgets_count, category: category)
      end
    end
  end
end
