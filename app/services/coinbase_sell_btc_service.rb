class CoinbaseSellBtcService < ApplicationService
  def initialize(user, sell_amount)
    @user = user
    @sell_amount = sell_amount
  end

  def call
    CoinbaseRefreshTokenRecoveryService.call(@user)
    res = sell(@sell_amount)
    begin
      success_transfer_amount = res["data"]["total"]["amount"].to_i
    rescue
      success_transfer_amount = nil
    end
    if success_transfer_amount == @sell_amount.to_i
      return {
                "status" => "success",
                "message" => "We successfully sold #{@sell_amount} EUR"
             }
    else
      return {
                "status" => "error",
                "message" => "We didn't manage to sell #{@sell_amount} EUR"
             }
    end
  end

  private

  def sell(sell_amount)
    url = "https://api.coinbase.com/v2/accounts/#{@user.coinbase_btc_account_id}/sells"
    res = HTTParty.post(url,
      headers: {
        "Content-Type"  => "application/json",
        "Authorization" => "Bearer #{@user.coinbase_token}"
      },
      body: {
        "total" => sell_amount,
        "currency" => "EUR",
        "payment_method" => @user.coinbase_eur_payment_method_id
      }.to_json
    )
    return res
  end
end
