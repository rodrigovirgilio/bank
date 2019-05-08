require 'rails_helper'

RSpec.describe TransactionHistoryService, type: :services do
  context '#call' do
    let(:transfer) { build :transfer }

    let(:source_account) do
      build_stubbed :account,
        id: transfer.source_account_id
    end

    let(:destination_account) do
      build_stubbed :account,
        id: transfer.destination_account_id
    end

    before do
      allow(Account).to receive(:find_by_id)
        .with(transfer.source_account_id)
        .and_return(source_account.id)

      allow(Account).to receive(:find_by_id)
        .with(transfer.destination_account_id)
        .and_return(destination_account.id)

      allow(TransferFundsService).to receive(:call)
        .with(source_account.id, destination_account.id, transfer.amount.to_d)
    end

    it 'create aacount transaction debit' do
      expect(AccountTransaction).to receive(:create)
        .with(
          account: transfer.source_account_id,
          amount: transfer.amount.to_d,
          type_transaction: AccountTransaction.type_transactions[:debit]
        ).once

      expect(AccountTransaction).to receive(:create)
        .with(
          account: transfer.destination_account_id,
          amount: transfer.amount.to_d,
          type_transaction: AccountTransaction.type_transactions[:credit]
        ).once

      TransactionHistoryService.call(transfer)
    end
  end
end
