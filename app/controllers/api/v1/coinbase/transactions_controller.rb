class Api::V1::Coinbase::TransactionsController < Api::V1::BaseController
  
  def sell
    user = User.find_by!(authentication_token: transaction_params[:token])
    sell_amount = transaction_params[:difference]
    message = CoinbaseSellBtcService.call(user, sell_amount)
    render json: { message: message }, status: :ok
  end

  def withdraw
    user = User.find_by!(authentication_token: transaction_params[:token])
    withdraw_amount = transaction_params[:price]
    message = CoinbaseWithdrawService.call(user, withdraw_amount)
    render json: { message: message }, status: :ok
  end

  private

  def transaction_params
    params.permit(:difference, :price, :token )
  end
end
