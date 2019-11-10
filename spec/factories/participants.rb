FactoryBot.define do
  factory :participant do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    participation_type { Faker::Lorem.word }
    event_ids do
      ([*0...5].sample).times.map do
        create(:event).id
      end
    end
  end
end
