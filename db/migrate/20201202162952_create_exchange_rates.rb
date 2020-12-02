class CreateExchangeRates < ActiveRecord::Migration[6.0]
  def change
    create_table :exchange_rates do |t|
      t.string :date
      t.string :currency_in
      t.string :currency_out
      t.float :exchange_rate

      t.timestamps
    end
  end
end
