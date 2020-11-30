class CoinbaseSellBtcService < ApplicationService
  def initialize(user, sell_amount)
    @user = user
    @sell_amount = sell_amount
  end

  def call
    CoinbaseRefreshTokenRecoveryService.call(@user)
    sell(@sell_amount)
  end

  private

  def sell(sell_amount)
    url = "https://api.coinbase.com/v2/accounts/#{@user.coinbase_btc_account_id}/sells"
    HTTParty.post(url,
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
  end
end