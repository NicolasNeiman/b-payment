class CoinbaseEurBalanceRecoveryService < ApplicationService
  def initialize(user)
    @user = user
    CoinbaseRefreshTokenRecoveryService.call(@user)
  end

  def call
    return { "error" => "We don't have an eur account" } unless @user.coinbase_eur_account_id

    url = "https://api.coinbase.com/v2/accounts/#{@user.coinbase_eur_account_id}"
    headers = {
      "Content-Type"  => "application/json",
      "Authorization" => "Bearer #{@user.coinbase_token}"
    }

    coinbase_api_answer = HTTParty.get(url, headers: headers)

    if coinbase_api_answer.keys.include? "data"
      balance = coinbase_api_answer["data"]["balance"]
    elsif coinbase_api_answer.keys.include? "data"
      
    begin
      balance = HTTParty.get(url, headers: headers)["data"]["balance"]
    rescue
      balance = { "error" => "We were not able to retrieve the balance" }
    end

    return balance
  end
end
