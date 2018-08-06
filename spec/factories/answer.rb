FactoryBot.define do
  factory :answer do
    user
    question
    text { Faker::Lorem.sentence }
  end

  trait :with_private_question do
    question { create(:question, :private) }
  end

  trait :with_public_question do
    question { create(:question, :public) }
  end
end
