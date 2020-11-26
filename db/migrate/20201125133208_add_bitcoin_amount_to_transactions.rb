class AddBitcoinAmountToTransactions < ActiveRecord::Migration[6.0]
  def change
    add_column :transactions, :bitcoin_amount, :float
  end
end
