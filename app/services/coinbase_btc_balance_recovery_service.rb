class CoinbaseBtcBalanceRecoveryService < ApplicationService
  def initialize(user)
    @user = user
    CoinbaseRefreshTokenRecoveryService.call(@user)
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

    @balance = coinbase_api_answer.dig("data", "balance")

    return @balance
  end

  def success?
    !@balance.nil?
  end
end