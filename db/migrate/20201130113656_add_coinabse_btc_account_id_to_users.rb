class AddCoinabseBtcAccountIdToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :coinbase_btc_account_id, :string
  end
end
