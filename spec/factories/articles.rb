FactoryBot.define do
  factory :article do
    title { Faker::Movie.quote }
    content { Faker::Quote.famous_last_words }
    status { 0 }
    user
  end
end
