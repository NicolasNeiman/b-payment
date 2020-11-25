class AddMonetizeToTransactions < ActiveRecord::Migration[6.0]
  def change
    add_monetize :transactions, :amount
  end
end
