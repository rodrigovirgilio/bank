require 'rails_helper'

RSpec.describe AccountTransaction, type: :model do
  context 'Association' do
    it { is_expected.to belong_to :account }
  end

  context 'Validation' do
    it { is_expected.to define_enum_for :type_transaction }
  end
end
