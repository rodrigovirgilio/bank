class AccountTransactionsController < ApplicationController
  def index
    @account_transactions = AccountTransaction.order(created_at: :desc)
  end

  def show
  end

  def new
    @transfer = Transfer.new
  end

  def create
    @transfer = Transfer.new(transfer_params)

    respond_to do |format|
      if @transfer.valid?
        @result = TransactionHistoryService.call(@transfer)
        format.html { redirect_to account_transactions_path, notice: t('.successfully') }
      else
        format.html { render :new }
      end
    end
  end

  private

  def transfer_params
    params
      .require(:transfer)
      .permit(
        :source_account_id,
        :destination_account_id,
        :amount,
        :type_transaction
      )
  end
end
