class AddCoinbaseEurAccountIdToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :coinbase_eur_account_id, :string
  end
end
