class Transfer
  include ActiveModel::Model

  attr_accessor :source_account_id, :destination_account_id, :amount
  attr_reader :source_account

  validates :source_account_id, :destination_account_id, :amount, presence: true
  validate :balance


  def balance
    return if amount.blank?
    return true unless (source_account.balance - formatted_amount).negative?

    errors.add(:base, 'Saldo Insuficiente')
  end

  private

  def source_account
    @source_account ||= Account.find(source_account_id)
  end

  def formatted_amount
    BigDecimal(amount.sub(',', '.'))
  end
end
