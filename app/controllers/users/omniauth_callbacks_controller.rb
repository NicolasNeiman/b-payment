class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  skip_before_action :verify_authenticity_token, only: :coinbase

  def coinbase
    auth = request.env["omniauth.auth"]

    current_user.name = auth.info.name
    current_user.coinbase_token = auth.credentials.token
    current_user.coinbase_token_expires = auth.credentials.expires
    current_user.coinbase_token_expires_at = auth.credentials.expires_at
    current_user.coinbase_refresh_token = auth.credentials.refresh_token

    current_user.save
    CoinbasePaypalIdRecoveryService.call(current_user)

    redirect_to profile_path
    # sign_in_and_redirect current_user, event: :authentication #this will throw if @user is not activated
    # set_flash_message(:notice, :success, kind: "Coinbase") if is_navigational_format?
  end

  def failure
    redirect_to root_path
  end
end