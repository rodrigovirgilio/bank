class Customer < ApplicationRecord
  has_and_belongs_to_many :accounts

  accepts_nested_attributes_for :accounts

  validates :name, presence: true, uniqueness: true
end
