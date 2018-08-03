FactoryBot.define do
  factory :tenant do
    name { Faker::Name.name }
    api_key { Faker::Crypto.md5 }
  end
end
