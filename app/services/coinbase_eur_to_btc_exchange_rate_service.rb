class CoinbaseEurToBtcExchangeRateService < ApplicationService
  def initialize
    @rate = nil
  end

  def call
    url = "https://api.coinbase.com/v2/exchange-rates?currency=EUR"

    begin
      coinbase_api_answer = HTTParty.get(url)
    rescue
      coinbase_api_answer = {}
    end

    rate = coinbase_api_answer.dig("data", "rates", "BTC")
    rate ? @rate = rate.to_f : @rate = nil
  end

  def success?
    !@rate.nil?
  end

  def rate
    @rate
  end
end
