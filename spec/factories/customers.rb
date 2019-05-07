FactoryBot.define do
  factory :customer do
    name { FFaker::Name.unique.name }
  end
end
