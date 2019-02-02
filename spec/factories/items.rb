FactoryBot.define do
  factory :item do
    name {"キングダム"}
    description {"今一番アツい漫画"}
    price { 100 }
    association :user
  end
end
