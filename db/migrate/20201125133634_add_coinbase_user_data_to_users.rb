class AddCoinbaseUserDataToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :name, :string
    add_column :users, :coinbase_token, :string
    add_column :users, :coinbase_token_expires, :boolean
    add_column :users, :coinbase_token_expires_at, :integer
    add_column :users, :coinbase_refresh_token, :string
  end
end
