FactoryBot.define do
    factory :todo do
      original_url { "https://" + Faker::Lorem.word + ".com" }
      short_url {Faker::Lorem.word}
      popularity { Faker::Number.number(10) }
    end
  end