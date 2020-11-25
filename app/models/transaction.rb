class Transaction < ApplicationRecord
  belongs_to :user, dependant: :destroy
end
