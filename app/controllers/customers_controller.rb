class CustomersController < ApplicationController
  before_action :set_customer, only: [:show, :edit, :update]

  def index
    @customers = Customer.all
  end

  def show
  end

  def new
    @customer = Customer.new
    @customer.accounts.new
  end

  def edit
  end

  def create
    @customer = Customer.new(customer_params)

    respond_to do |format|
      if @customer.save
        format.html { redirect_to @customer, notice: t('.successfully') }
        format.json { render :show, status: :created, location: @customer }
      else
        format.html { render :new }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @customer.update(customer_params)
        format.html { redirect_to @customer, notice: t('.successfully_updated') }
        format.json { render :show, status: :ok, location: @customer }
      else
        format.html { render :edit }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_customer
    @customer = Customer.find(params[:id])
  end

  def customer_params
    params.require(:customer).permit(:name, { accounts_attributes: [:name, :balance] })
  end
end
