FactoryGirl.define do
  factory :income_source do
    name { Faker::Company.name[0..19] }
    amount 1000.0
    schedule
    start_date '2014-01-01'
    end_date '2017-12-31'
    account

    factory :biweekly_income_source do
      schedule { create(:biweekly_schedule) }
    end

    factory :semi_monthly_income_source do
      schedule { create(:semi_monthly_schedule) }
    end
  end
end
