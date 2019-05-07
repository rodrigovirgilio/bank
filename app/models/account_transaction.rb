class AccountTransaction < ApplicationRecord
  belongs_to :account

  enum type_transaction: { credit: 0, debit: 1 }
end
