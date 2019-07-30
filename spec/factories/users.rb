FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    sequence(:email) { |n| "#{n}_" + Faker::Internet.email }
    password { Faker::Internet.password(8) }

    trait :with_articles do
      transient do
        article_count {5}
      end

      after(:create) do |user, evaluator|
        evaluator.article_count.times do
          create(:article, user: user)
        end
      end
    end

  end
end