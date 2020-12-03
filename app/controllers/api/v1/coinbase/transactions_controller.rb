class Api::V1::Coinbase::TransactionsController < Api::V1::BaseController
  def sell
    user = User.find_by!(authentication_token: transaction_params[:token])
    sell_amount = transaction_params[:difference]
    url = transaction_params[:url]
    coinbase_sell_btc_service = CoinbaseSellBtcService.new(user, sell_amount, url)
    coinbase_sell_btc_service.call
    if coinbase_sell_btc_service.success?
      render json: { response: {"status" => "success"} }, status: :ok
    else
      render json: { response: {"status" => "error"} }, status: :bad_request
    end
  end

  def withdraw
    user = User.find_by!(authentication_token: transaction_params[:token])
    withdraw_amount = transaction_params[:price]
    coinbase_withdraw_service = CoinbaseWithdrawService.new(user, withdraw_amount)
    coinbase_withdraw_service.call
    if coinbase_withdraw_service.success?
      render json: { response: {"status" => "success"} }, status: :ok
    else
      render json: { response: {"status" => "error"} }, status: :bad_request
    end
  end

  private

  def transaction_params
    params.permit(:difference, :price, :token, :url)
  end
end
