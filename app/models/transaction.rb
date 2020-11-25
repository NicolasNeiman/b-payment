class Transaction < ApplicationRecord
  belongs_to :user, dependent: :destroy
  monetize :amount_cents
  validates :amount_cents, presence: true
end
