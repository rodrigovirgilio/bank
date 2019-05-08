require 'rails_helper'

RSpec.describe Transfer, type: :model do
  context 'Validation' do
    it { is_expected.to validate_presence_of :source_account_id }
    it { is_expected.to validate_presence_of :destination_account_id }
    it { is_expected.to validate_presence_of :amount }
  end

  context '#balance' do
    let(:transfer) { build :transfer }
    let(:source_account) { build_stubbed :account, id: transfer.source_account_id }

    before do
      allow(Account).to receive(:find).with(transfer.source_account_id).and_return(source_account)
    end

    it 'insufficient balance' do
      expect(transfer.balance).to eql(["Saldo Insuficiente"])
    end
  end
end
