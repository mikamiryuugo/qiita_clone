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

    trait :with_comment do
      after(:create) do |user|
        user_article = create(:article, user: user)
        create(:comment, user: user, article: user_article)
      end
    end

  end
end