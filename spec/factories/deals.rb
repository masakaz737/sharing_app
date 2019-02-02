FactoryBot.define do
  factory :deal do
    association :item
    lender {item.user}
    association :borrower
    unit_price {item.price}
  end
end
