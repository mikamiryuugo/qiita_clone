FactoryBot.define do
  factory :article do
    title { Faker::Movie.quote }
    content { Faker::Quote.famous_last_words }
    user
  end

  trait :published do
    status {:published}
  end
end
