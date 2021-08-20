FactoryBot.define do
  factory :inventory do
    name { Faker::Hipster.word }
    description { Faker::Hipster.word }
    serial_no { 12345 }
    purchase_date { Date.today.beginning_of_year }
    price { 100 }
    quantity { 10 }
  end
end
