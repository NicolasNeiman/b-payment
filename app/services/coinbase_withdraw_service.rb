class CoinbaseWithdrawService < ApplicationService
  def initialize(user, withdraw_amount)
    @user = user
    @payment_method_id = @user.coinbase_paypal_account_id
    @coinbase_eur_account_id = @user.coinbase_eur_account_id
    @withdraw_amount = withdraw_amount
  end

  def call
    CoinbaseRefreshTokenRecoveryService.call(@user)
    withdraw(@withdraw_amount)
  end

  private

  def withdraw(withdraw_amount)
    url = "https://api.coinbase.com/v2/accounts/#{@coinbase_eur_account_id}/withdrawals"
    HTTParty.post(url,
      headers: {
        "Content-Type"  => "application/json",
        "Authorization" => "Bearer #{@user.coinbase_token}"
      },
      body: {
        "amount" => withdraw_amount,
        "currency" => "EUR",
        "payment_method" => @payment_method_id
      }.to_json,
      debug_output: $stdout
    )
  end
end
