FactoryBot.define do
  factory :account_transaction do
    account
    balance { '9.99' }
  end
end
