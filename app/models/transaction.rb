class Transaction < ApplicationRecord
  belongs_to :user, dependant: :destroy
  monetize :amount_cents
end
