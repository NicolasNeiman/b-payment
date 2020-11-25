class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[coinbase]

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.extra.raw_info.email
      user.password = Devise.friendly_token[0, 20]
      user.name = auth.info.name
      user.coinbase_token = auth.credentials.token
      user.coinbase_token_expires = auth.credentials.expires
      user.coinbase_token_expires_at = auth.credentials.expires_at
      user.coinbase_refresh_token = auth.credentials.refresh_token
      # If you are using confirmable and the provider(s) you use validate emails,
      # uncomment the line below to skip the confirmation emails.
      # user.skip_confirmation!
    end
  end
end
