class TransactionHistory
  attr_reader :transfer

  def initialize(transfer = {})
    @transfer = transfer
  end

  def self.call(transfer = {})
    new(transfer).call
  end

  def call
    ActiveRecord::Base.transaction do
      create_account_transaction_debit
      create_account_transaction_credit
      debit_source_account
      credit_destination_account
    rescue ActiveRecord::RecordNotFound
      false
    end
  end

  private

  def source_account
    @source_account ||= Account.find_by_id(transfer.source_account_id)
  end

  def destination_account
    @destination_account ||= Account.find_by_id(transfer.destination_account_id)
  end

  def amount
    @amount ||= BigDecimal(transfer.amount.sub(',', '.'))
  end

  def create_account_transaction_debit
    AccountTransaction.create(
      account: source_account,
      amount: amount,
      type_transaction: AccountTransaction.type_transactions[:debit]
    )
  end

  def create_account_transaction_credit
    AccountTransaction.create(
      account: destination_account,
      amount: amount,
      type_transaction: AccountTransaction.type_transactions[:credit]
    )
  end

  def debit_source_account
    balance = source_account.balance - amount
    source_account.update(balance: balance)
  end

  def credit_destination_account
    balance = destination_account.balance + amount
    destination_account.update(balance: balance)
  end
end
