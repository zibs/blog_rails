class Api::BaseController < ApplicationController
  protect_from_forgery with: :null_session
  before_action :authenticate_api_key
  # http://localhost:3000/api/v1/posts?api_key=3800a35e06814aea0597a96bf0abf59f7c22f3a236fdd032c567bdcfb1717afd

  private

    def authenticate_api_key
      @user = User.find_by(api_key: params[:api_key])
      head :unauthorized unless @user
    end
end
