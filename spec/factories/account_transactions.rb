FactoryBot.define do
  factory :account_transaction do
    account
    amount { '9.99' }
  end
end
