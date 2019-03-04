FactoryBot.define do
  factory :notification do
    user { nil }
    deal { nil }
    message { "MyText" }
  end
end
