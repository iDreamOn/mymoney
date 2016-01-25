require 'faker'

FactoryGirl.define do
  factory :account do
    account_type { Faker::Business.credit_card_type }
    name { Faker::Company.name[0...19] }
    user

    factory :account_with_debts do
      transient do
        debts_count 2
      end
      after(:create) do |account, evaluator|
        create_list(:debt, evaluator.debts_count, account: account)
      end
    end

    factory :account_with_income_sources do
      transient do
        income_sources_count 1
      end
      after(:create) do |account, evaluator|
        create_list(:income_source, evaluator.income_sources_count, account: account)
      end
    end

    factory :account_with_account_balances do
      transient do
        account_balances_count 2
      end
      after(:create) do |account, evaluator|
        create_list(:account_balance, evaluator.account_balances_count, account: account)
      end
    end

    factory :account_with_debt_balances do
      transient do
        debt_balance { FactoryGirl.create(:debt_balance) }
        debt { FactoryGirl.create(:debt) }
      end
      after(:create) do |account, evaluator|
        evaluator.debt.debt_balances << evaluator.debt_balance
        account.debts << evaluator.debt
      end
    end
  end
end
