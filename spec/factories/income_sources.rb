FactoryGirl.define do
  factory :income_source do
    name { Faker::Company.name[0..19] }
    amount 1000.0
    schedule '{"validations":{"day":[5]},"rule_type":"IceCube::WeeklyRule","interval":1,"until":null,"count":null,"week_start":0}'
    start_date '2014-01-01'
    end_date '2017-12-31'
    account

    factory :biweekly_income_source do
      schedule '{"validations":{"day":[5]},"rule_type":"IceCube::WeeklyRule","interval":2,"week_start":0}'
    end

    factory :semi_monthly_income_source do
      schedule '{"validations":{"day_of_week":{},"day_of_month":[15,-1]},"rule_type":"IceCube::MonthlyRule","interval":1,"week_start":0,"until":null,"count":null}'
    end
  end
end
