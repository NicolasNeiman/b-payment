class Api::V1::Coinbase::BalancesController < Api::V1::BaseController
  def show
    user = User.find_by!(email: user_params[:email])
    if user.authentication_token == (user_params[:token])
      coinbase_eur_balance_recovery_service = CoinbaseEurBalanceRecoveryService.new(user)
      eur_balance = coinbase_eur_balance_recovery_service.call
      coinbase_btc_balance_recovery_service = CoinbaseBtcBalanceRecoveryService.new(user)
      btc_balance = coinbase_btc_balance_recovery_service.call
      if coinbase_eur_balance_recovery_service.success? && coinbase_btc_balance_recovery_service.success?
        render json: { user: { eur_balance: eur_balance, btc_balance: btc_balance } }, status: :ok
      else
        render json: { error: "wrong token" }, status: :unauthorized
      end
    end
  end

  private

  def user_params
    params.permit(:email, :token)
  end
end

