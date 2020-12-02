class CoinbaseSellBtcService < ApplicationService
  def initialize(user, sell_amount)
    @user = user
    @sell_amount = sell_amount
    CoinbaseRefreshTokenRecoveryService.call(@user)
  end

  def call
    begin
      coinbase_api_answer = HTTParty.post(
        url,
        headers: headers,
        body: body
      )
    rescue
      coinbase_api_answer = {}
    end

    @sold_amount = coinbase_api_answer.dig("data", "total", "amount")
    if @sold_amount
      coinbase_eur_to_btc_exchange_rate_service = CoinbaseEurToBtcExchangeRateService.new
      rate = coinbase_eur_to_btc_exchange_rate_service.call

      Transaction.create(
        user: @user,
        amount_cents: @sold_amount.to_f * 100,
        amount_currency: "EUR",
        bitcoin_amount_cents: (@sold_amount.to_f * rate) * 100_000_000,
        bitcoin_amount_currency: "BTC",
        url: "www.boulanger.com"
      )
    end
  end

  def success?
    !@sold_amount.nil?
  end

  private

  def url
    "https://api.coinbase.com/v2/accounts/#{@user.coinbase_btc_account_id}/sells"
  end

  def headers
    {
      "Content-Type"  => "application/json",
      "Authorization" => "Bearer #{@user.coinbase_token}"
    }
  end

  def body
    {
      "total" => @sell_amount,
      "currency" => "EUR",
      "payment_method" => @user.coinbase_eur_payment_method_id
    }.to_json
  end
end
