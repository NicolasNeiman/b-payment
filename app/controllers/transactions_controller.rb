class TransactionsController < ApplicationController
  def index
    @transactions = Transaction.where( user: current_user)
  end
end
