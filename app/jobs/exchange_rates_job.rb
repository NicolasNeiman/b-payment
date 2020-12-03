class ExchangeRatesJob < ApplicationJob
  queue_as :default

  def perform
    # Do something later
    begin
      coinbase_api_answer = HTTParty.get(url, headers: headers)
    rescue
      coinbase_api_answer = {}
    end
    ExchangeRate.create(date: Time.now.strftime("%Y-%m-%d"),
                        currency_in: coinbase_api_answer.dig("data", "base"),
                        currency_out: coinbase_api_answer.dig("data", "currency"),
                        exchange_rate: coinbase_api_answer.dig("data", "amount"))
  end

  private

  def url
    "https://api.coinbase.com/v2/prices/BTC-EUR/spot"
  end

  def headers
    {
      "Content-Type" => "application/json"
    }
  end
end
