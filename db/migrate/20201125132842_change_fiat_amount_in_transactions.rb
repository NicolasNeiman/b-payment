class ChangeFiatAmountInTransactions < ActiveRecord::Migration[6.0]
  def change
    remove_column :transactions, :fiat_amount
  end
end
