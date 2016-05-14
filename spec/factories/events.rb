FactoryGirl.define do
  factory :event do
    name { Faker::Name.name }
    location { Faker::Company.name }
    start_date { Faker::Date.between(2.year.ago, Time.zone.today) }
    end_date { Faker::Date.between(2.year.ago, Time.zone.today) }
    workload { Faker::Number.number(3) }
  end
end
