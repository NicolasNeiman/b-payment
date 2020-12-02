namespace :exchange_rates do
  desc "Updating the exchange rates DB"
  task update_all: :environment do
    puts "Retrieving exchange rates"
    ExchangeRatesJob.perform_later
  end
end
