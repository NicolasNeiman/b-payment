# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
puts "Pulling historical bitcoin rates"
headers = { "Content-Type" => "application/json" }
start_date = Date.new(2019,1,1)
end_date = Date.new(2020,12,2)
(1..(end_date-start_date).to_i).each do |i|
  date = (start_date + i).strftime('%Y-%m-%d')
  puts "Pulling data for #{date} ..."
  url = "https://api.coinbase.com/v2/prices/BTC-EUR/spot?date=#{date}"
  coinbase_api_answer = HTTParty.get(url, headers: headers)
  ExchangeRate.create(date: date,
                      currency_in: coinbase_api_answer.dig("data", "base"),
                      currency_out: coinbase_api_answer.dig("data", "currency"),
                      exchange_rate: coinbase_api_answer.dig("data", "amount"))
  sleep(0.2)
end
