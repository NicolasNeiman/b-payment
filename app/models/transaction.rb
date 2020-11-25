class Transaction < ApplicationRecord
  belongs_to :user, dependant: :destroy
  monetize :amount_cents
  validates :amount_cents, presence: true
end
