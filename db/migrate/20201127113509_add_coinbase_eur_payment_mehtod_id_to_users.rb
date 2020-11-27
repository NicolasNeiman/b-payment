class AddCoinbaseEurPaymentMehtodIdToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :coinbase_eur_payment_method_id, :string
  end
end
