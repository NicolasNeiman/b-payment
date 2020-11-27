class CoinbaseEurBalanceRecoveryService < ApplicationService
  def initialize(user)
    @user = user
  end

  def call
    
    get_balance(@user.coinbase_eur_account_id)
  end

  private

  def get_balance(account_id)
    url = "https://api.coinbase.com/v2/accounts/#{account_id}"
    headers = {
      "Content-Type"  => "application/json",
      "Authorization" => "Bearer #{@user.coinbase_token}"
    }
    account = HTTParty.get(url, :headers => headers)["data"]
    return account["balance"]
  end
end
