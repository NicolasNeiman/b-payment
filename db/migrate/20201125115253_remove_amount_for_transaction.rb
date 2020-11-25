class RemoveAmountForTransaction < ActiveRecord::Migration[6.0]
  def change
    remove_column :transactions, :bitcoin_amount
  end
end
