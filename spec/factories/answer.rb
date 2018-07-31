FactoryBot.define do
  factory :answer do
    user
    text { Faker::Lorem.sentence }
  end
end
