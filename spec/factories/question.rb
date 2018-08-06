FactoryBot.define do
  factory :question do
    tenant
    user
    text { Faker::Lorem.sentence }
    is_private { Faker::Boolean.boolean }
  end

  trait :private do
    is_private true
  end

  trait :public do
    is_private false
  end
end
