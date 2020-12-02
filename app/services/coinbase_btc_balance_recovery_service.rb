class CoinbaseBtcBalanceRecoveryService < ApplicationService
  def initialize(user)
    @user = user
    CoinbaseRefreshTokenRecoveryService.call(@user)
    @rate = CoinbaseEurToBtcExchangeRateService.call
    @balance = nil
  end

  def call
    url = "https://api.coinbase.com/v2/accounts/#{@user.coinbase_btc_account_id}"
    headers = {
      "Content-Type"  => "application/json",
      "Authorization" => "Bearer #{@user.coinbase_token}"
    }

    begin
      coinbase_api_answer = HTTParty.get(url, headers: headers)
    rescue
      coinbase_api_answer = {}
    end

    original_balance = coinbase_api_answer.dig("data", "balance")

    unless original_balance.nil?
      eur_balance = (original_balance["amount"].to_f / @rate).to_s
      @balance = {
        "BTC" => original_balance["amount"],
        "EUR" => eur_balance
      }
    end
    return @balance
  end

  def success?
    !@balance.nil?
  end
end