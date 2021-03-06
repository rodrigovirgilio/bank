require 'rails_helper'

RSpec.describe Account, type: :model do
  context 'Association' do
    it { is_expected.to have_and_belong_to_many :customers }
  end

  context 'Validation' do
    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_uniqueness_of :name }

    it { is_expected.to validate_presence_of :balance }
  end
end
