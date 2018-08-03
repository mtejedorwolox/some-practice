FactoryBot.define do
  factory :question do
    tenant
    user
    text { Faker::Lorem.sentence }
    is_private { Faker::Boolean.boolean }
  end
end
