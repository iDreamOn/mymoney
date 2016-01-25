FactoryGirl.define do
  factory :schedule do
    initialize_with { Schedule.find_or_initialize_by(rule: "{\"validations\":{\"day\":[5]},\"rule_type\":\"IceCube::WeeklyRule\",\"interval\":1,\"week_start\":0}") }

    factory :biweekly_schedule do
      initialize_with { Schedule.find_or_initialize_by(rule: "{\"validations\":{\"day\":[5]},\"rule_type\":\"IceCube::WeeklyRule\",\"interval\":2,\"week_start\":0}") }
    end

    factory :semi_monthly_schedule do
      initialize_with { Schedule.find_or_initialize_by(rule: "{\"validations\":{\"day_of_week\":{},\"day_of_month\":[15,-1]},\"rule_type\":\"IceCube::MonthlyRule\",\"interval\":1,\"week_start\":0}") }
    end

    factory :duplicate_schedule do
      initialize_with { Schedule.new(rule: "{\"validations\":{\"day\":[5]},\"rule_type\":\"IceCube::WeeklyRule\",\"interval\":1,\"week_start\":0}") }
    end
  end
end
