require 'rails_helper'

RSpec.describe Customer, type: :model do
  context 'Association' do
    it { is_expected.to have_and_belong_to_many :accounts }

    it { is_expected.to accept_nested_attributes_for :accounts }
  end

  context 'Validation' do
    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_uniqueness_of :name }
  end
end
