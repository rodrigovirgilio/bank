class CreateAccounts < ActiveRecord::Migration[5.2]
  def change
    create_table :accounts do |t|
      t.string :name
      t.decimal :amount, precision: 8, scale: 2

      t.timestamps
    end
  end
end
