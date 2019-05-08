require 'rails_helper'

RSpec.describe TransferFundsService, type: :services do
  context '#call' do
    context 'debit source account' do
      let(:source_account) { create :account, balance: '100'.to_d }
      let(:destination_account) { create :account }
      let(:amount) { '90'.to_d }

      it 'debit value to balance' do
        TransferFundsService.call(source_account, destination_account, amount)

        expect(source_account.balance).to eql(10)
      end
    end

    context 'credit source account' do
      let(:source_account) { create :account }
      let(:destination_account) { create :account, balance: '90'.to_d }
      let(:amount) { '100'.to_d }

      it 'credit value to balance' do
        TransferFundsService.call(source_account, destination_account, amount)

        expect(destination_account.balance).to eql(190)
      end
    end
  end
end
