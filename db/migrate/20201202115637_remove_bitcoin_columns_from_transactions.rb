class RemoveBitcoinColumnsFromTransactions < ActiveRecord::Migration[6.0]
  def change
    remove_column :transactions, :bitcoin_amount_cents, :string
    remove_column :transactions, :bitcoin_amount_currency, :string
    remove_column :transactions, :amount_cents, :string
  end
end
