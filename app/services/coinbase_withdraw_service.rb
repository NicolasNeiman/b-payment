class CoinbaseWithdrawService < ApplicationService
  def initialize(user)
    @user = user
    @payment_method_id = @user.coinbase_paypal_account_id
    @coinbase_eur_account_id = @user.coinbase_eur_account_id
  end

  def call(withdraw_amount)
    withdraw(withdraw_amount)
  end

  private

  def withdraw(withdraw_amount)
    url = "https://api.coinbase.com/v2/accounts/#{@coinbase_eur_account_id}/withdrawals"
    headers = {
      "Content-Type"  => "application/json",
      "Authorization" => "Bearer #{@user.coinbase_token}"
    }
    payload = {
      "amount" => withdraw_amount,
      "currency" => "EUR",
      "payment_method" => @payment_method_id
    }
    HTTParty.post(
      url,
      headers: headers,
      body: payload)
  end
end
