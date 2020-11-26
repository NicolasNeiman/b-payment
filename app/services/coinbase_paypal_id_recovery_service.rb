class CoinbasePaypalIdRecoveryService < ApplicationService
  def initialize(user)
    @user = user
  end

  def call
    url = "https://api.coinbase.com/v2/payment-methods"
    headers = {
      "Content-Type"  => "application/json",
      "Authorization" => "Bearer #{@user.coinbase_token}"
    }
    payment_methods = HTTParty.get(url, :headers => headers)["data"]
    paypal_accounts = payment_methods.select { |payment_method| payment_method["type"] == "paypal_account"}
    paypal_account = paypal_accounts.first
    @user.coinbase_paypal_account = paypal_account
    @user.save
  end
end
