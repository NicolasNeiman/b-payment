class AddCoinbasePayPalAccountToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :coinbase_paypal_account_id, :string
  end
end
