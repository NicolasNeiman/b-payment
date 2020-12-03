class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def home
  end

  def profile
    # raise
    # @providers = resource_class.omniauth_providers
    # @resource_name = resource_name
  end
  
  def dashboard
    @data = {}
    ExchangeRate.all.each do |exchange_rate|
      if exchange_rate.date >= '2020-09-01'
        @data[exchange_rate.date] = exchange_rate.exchange_rate
      end
    end
    # raise
  end
end
