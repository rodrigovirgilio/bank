class Customer < ApplicationRecord
  has_and_belongs_to_many :accounts

  validates :name, presence: true, uniqueness: true
end
