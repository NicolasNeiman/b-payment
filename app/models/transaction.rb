class Transaction < ApplicationRecord
  belongs_to :user
  monetize :amount_cents
  monetize :bitcoin_amount_cents
  validates :bitcoin_amount_cents, :amount_cents, presence: true
end
