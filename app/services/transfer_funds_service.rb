class TransferFundsService
  def initialize(source_account, destination_account, amount)
    @source_account = source_account
    @destination_account = destination_account
    @amount = amount
  end

  def self.call(*args)
    new(*args).call
  end

  def call
    ActiveRecord::Base.transaction do
      debit_source_account
      credit_destination_account
    end
  end

  private

  def debit_source_account
    balance = source_account.balance - amount
    source_account.update(balance: balance)
  end

  def credit_destination_account
    balance = destination_account.balance + amount
    destination_account.update(balance: balance)
  end

  attr_reader :source_account, :destination_account, :amount
end
