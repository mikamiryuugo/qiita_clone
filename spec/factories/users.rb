FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "#{n}_" + Faker::Name.name }
    sequence(:email) { |n| "#{n}_" + Faker::Internet.email }
    password { Faker::Internet.password(8) }
  end
end