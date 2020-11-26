class User < ApplicationRecord
  has_many :transactions, dependent: :destroy
  acts_as_token_authenticatable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[coinbase]

  def coinbase_token?
    coinbase_token.present?
  end

  def accounts_set?
    coinbase_paypal_account_id.present? 
    # && coinbase_eur_account_id.present?
  end

  def all_set?
    coinbase_token? && accounts_set?
  end
end
