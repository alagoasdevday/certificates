# frozen_string_literal: true

FactoryBot.define do
  factory :event do
    name { Faker::Name.name }
    location { Faker::Company.name }
    start_date { Faker::Date.between(from: 2.year.ago, to: Time.zone.today) }
    end_date { Faker::Date.between(from: 2.year.ago, to: Time.zone.today) }
    workload { Faker::Number.number(digits: 3) }
  end
end
