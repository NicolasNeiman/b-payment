class Api::V1::Coinbase::BalancesController < Api::V1::BaseController
  def show
    user = User.find_by!(email: user_params[:email])
    if user.authentication_token == (user_params[:token])
      coinbase_eur_balance_recovery_service = CoinbaseEurBalanceRecoveryService.new(user)
      balance = coinbase_eur_balance_recovery_service.call
      if coinbase_eur_balance_recovery_service.success?
        render json: { user: { balance: balance } }, status: :ok
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
