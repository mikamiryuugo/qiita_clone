FactoryBot.define do
  factory :article do
    title { Faker::Movie.quote }
    content { Faker::Quote.famous_last_words }
    user
  end

  trait :with_published_article do
    status {:published}
  end
end
