class Transaction < ApplicationRecord
  belongs_to :user, dependent: :destroy
end
