class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def home
  end

  def profile
    # raise
    # @providers = resource_class.omniauth_providers
    # @resource_name = resource_name
  end
end
