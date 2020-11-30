class CoinbaseWithdrawService < ApplicationService
  def initialize(user, withdraw_amount)
    @user = user
    @payment_method_id = @user.coinbase_paypal_account_id
    @coinbase_eur_account_id = @user.coinbase_eur_account_id
    @withdraw_amount = withdraw_amount
  end

  def call
    res = withdraw(@withdraw_amount)
    begin
      success_transfer_amount = res["data"]["amount"]["amount"].to_i
    rescue
      success_transfer_amount = nil
    end
    if success_transfer_amount == @withdraw_amount.to_i
      return { "success" => "#{@withdraw_amount} EUR was withdraw and sent to your PayPal account" }
    else
      return {"error" => "We didn't manage to transfer #{@withdraw_amount} EUR to your account"}
    end
  end


  private

  def withdraw(withdraw_amount)
    url = "https://api.coinbase.com/v2/accounts/#{@coinbase_eur_account_id}/withdrawals"
    res = HTTParty.post(url,
      headers: {
        "Content-Type"  => "application/json",
        "Authorization" => "Bearer #{@user.coinbase_token}"
      },
      body: {
        "amount" => withdraw_amount,
        "currency" => "EUR",
        "payment_method" => @payment_method_id
      }.to_json
    )
    return res
  end
end
