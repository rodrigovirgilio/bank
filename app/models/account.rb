class Account < ApplicationRecord
  has_and_belongs_to_many :customers

  validates :name, presence: true, uniqueness: true
  validates :amount, presence: true
end
