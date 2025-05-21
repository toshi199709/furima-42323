FactoryBot.define do
  factory :item do
    name                  { 'Sample Item' }
    description           { 'This is a description' }
    category_id           { 2 }
    condition_id          { 2 }
    shipping_fee_status_id { 2 }
    prefecture_id         { 2 }
    shipping_day_id       { 2 }
    price                 { 1000 }
    association :user
  end
end
