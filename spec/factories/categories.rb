FactoryBot.define do
  factory :category do
    sequence(:name) { |n| "CATEGORY_NAME#{n}"}
  end
end
