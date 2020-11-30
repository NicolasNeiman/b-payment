class Api::V1::Transactions::BalancesController < Api::V1::BaseController

  def show
    user = User.find_by!(email: user_params[:email])
    if user.authentication_token == (user_params[:token])
      balance = CoinbaseEurBalanceRecoveryService.call(user)
      render json: { user: { balance: balance } }, status: :ok
    else
      render json: { error: "wrong token" }, status: :unauthorized
    end
  end

  private

  def user_params
    params.permit(:email, :token)
  end
end

# curl http://localhost:3000/api/v1/transactions/balance \
#   -d email=mondaytest@gmail.com  \
#   -d token=aUHopL2G3jM6PynUtDcJ

#   curl -i -X GET \
#        -d ' { { "email": "mondaytest@gmail.com", "token": "aUHopL2G3jM6PynUtDcJ" } } ' \
#        http://localhost:3000/api/v1/transactions/balance
