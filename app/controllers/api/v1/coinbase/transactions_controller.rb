class Api::V1::Coinbase::TransactionsController < Api::V1::BaseController
  
  def sell
    user = User.find_by!(authentication_token: transaction_params[:token])
    sell_amount = transaction_params[:difference]
    response = CoinbaseSellBtcService.call(user, sell_amount)
    render json: { response: response }, status: :ok
  end

  def withdraw
    user = User.find_by!(authentication_token: transaction_params[:token])
    withdraw_amount = transaction_params[:price]
    response = CoinbaseWithdrawService.call(user, withdraw_amount)
    render json: { response: response }, status: :ok
  end

  private

  def transaction_params
    params.permit(:difference, :price, :token )
  end
end
