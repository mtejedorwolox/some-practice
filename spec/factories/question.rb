FactoryBot.define do
  factory :question do
    user
    text { Faker::Lorem.sentence }
    is_private { Faker::Boolean.boolean }
  end
end
