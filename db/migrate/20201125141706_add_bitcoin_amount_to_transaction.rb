class AddBitcoinAmountToTransaction < ActiveRecord::Migration[6.0]
  def change
    add_monetize :transactions, :bitcoin_amount
  end
end
