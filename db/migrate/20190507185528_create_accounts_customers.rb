class CreateAccountsCustomers < ActiveRecord::Migration[5.2]
  def change
    create_table :accounts_customers, id: false do |t|
      t.belongs_to :account, index: true
      t.belongs_to :customer, index: true
    end
  end
end
