class CoinbaseWithdrawService < ApplicationService
  def initialize(user, withdraw_amount)
    @user = user
    @withdraw_amount = withdraw_amount
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
    @withdrawn_amount = coinbase_api_answer.dig("data", "amount", "amount")
  end

  def success?
    !@withdrawn_amount.nil?
  end

  private

  def url
    "https://api.coinbase.com/v2/accounts/#{@user.coinbase_eur_account_id}/withdrawals"
  end

  def headers
    {
      "Content-Type"  => "application/json",
      "Authorization" => "Bearer #{@user.coinbase_token}"
    }
  end

  def body
    {
      "amount" => @withdraw_amount,
      "currency" => "EUR",
      "payment_method" => @user.coinbase_paypal_account_id
    }.to_json
  end
end
