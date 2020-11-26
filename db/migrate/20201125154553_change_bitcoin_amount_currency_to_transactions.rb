class ChangeBitcoinAmountCurrencyToTransactions < ActiveRecord::Migration[6.0]
  def change
    change_column :transactions, :bitcoin_amount_currency, :string, :default => "BTC"
  end
end
