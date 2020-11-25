# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
puts "the seed begin"
Money.add_rate("USD", "BTC", 0.000052)
30.times do
  amount = rand(100..10000)
 transac = Transaction.new(
  user_id: 1,
  amount_cents: amount,
  amount_currency: "USD",
  bitcoin_amount_cents: (Money.us_dollar(amount).exchange_to("BTC")*100000000).to_f,
  url: Faker::Internet.email,
  )
  transac.save!
end
puts "the seed is finish"
