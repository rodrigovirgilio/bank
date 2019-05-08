FactoryBot.define do
  factory :transfer do
    source_account_id { FFaker::Random.rand(1..3) }
    destination_account_id { FFaker::Random.rand(1..3) }
    amount { '100' }
  end
end
