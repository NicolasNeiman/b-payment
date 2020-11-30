class Api::V1::Coinbase::TransactionsController < Api::V1::BaseController
  
  def create
    user = User.find_by!(authentication_token: transaction_params[:token])
    sell_amount = transaction_params[:difference]
    CoinbaseSellBtcService.new(user).call(sell_amount)
    render json: { message: "Success" }, status: :ok
  end

  private

  def transaction_params
    params.permit(:difference, :price, :token )
  end
end

