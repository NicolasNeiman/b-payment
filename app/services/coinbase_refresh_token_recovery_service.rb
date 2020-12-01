class CoinbaseRefreshTokenRecoveryService < ApplicationService
  REFRESH_TIME_MINUTES = 90
  def initialize(user)
    @user = user
  end

  def call
    if Time.now - @user.updated_at > 60 * REFRESH_TIME_MINUTES || @user.coinbase_token.nil?
      refresh_tokens = get_refresh_tokens(@user)
        if refresh_tokens["refresh_token"] && refresh_tokens["access_token"]
          @user.update(
            coinbase_token: refresh_tokens["access_token"],
            coinbase_refresh_token: refresh_tokens["refresh_token"]
          )
        end
    end
  end

  def get_refresh_tokens(user)
    url = "https://api.coinbase.com/oauth/token"

    options = {
      body: {
        "grant_type" => "refresh_token",
        "client_id" => ENV['COINBASE_CLIENT_ID'],
        "client_secret" => ENV['COINBASE_SECRET_ID'],
        "refresh_token" => user.coinbase_refresh_token
      }
    }
    return HTTParty.post(url, options)
  end
end
