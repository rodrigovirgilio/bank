FactoryBot.define do
  factory :account do
    name { FFaker::Name.unique.name }
    balance { '9.99' }
  end
end
