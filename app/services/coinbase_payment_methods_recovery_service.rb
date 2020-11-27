class CoinbasePaymentMethodsRecoveryService < ApplicationService
  def initialize(user)
    @user = user
  end

  def call
    payment_methods = get_payment_methods
    @user.coinbase_paypal_account_id = get_paypal_account_id(payment_methods)
    eur_account = get_eur_account(payment_methods)
    @user.coinbase_eur_account_id = eur_account[:eur_account_id]
    @user.coinbase_eur_payment_method_id = eur_account[:eur_payment_method_id]
    @user.save
  end

  private

  def get_payment_methods
    url = "https://api.coinbase.com/v2/payment-methods"
    headers = {
      "Content-Type"  => "application/json",
      "Authorization" => "Bearer #{@user.coinbase_token}"
    }
    return HTTParty.get(url, :headers => headers)["data"]
  end

  def get_paypal_account_id(payment_methods)
    paypal_account = payment_methods.find { |payment_method| payment_method["type"] == "paypal_account"}
    begin
      paypal_account_id = paypal_account["id"]
    rescue
      paypal_account_id = nil
    end
    return paypal_account_id
  end

  def get_eur_account(payment_methods)
    eur_account = payment_methods.find do |payment_method|
      payment_method["type"] == "fiat_account" && payment_method["name"] == "EUR Wallet"
    end

    begin
      eur_payment_method_id = eur_account["id"]
      eur_account_id = eur_account["fiat_account"]["id"]
    rescue
      eur_payment_method_id = nil
      eur_account_id = nil
    end

    eur_account = {
      eur_account_id: eur_account_id,
      eur_payment_method_id: eur_payment_method_id
    }

    return eur_account
  end
end
