class SupportsController < ApplicationController
  def home
    render json: { package: 'go-rails-api', version: '0.0.1' }
  end
end
