FactoryBot.define do
  factory :account do
    name { FFaker::Name.unique.name }
    amount { '9.99' }
  end
end
