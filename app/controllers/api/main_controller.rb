class Api::MainController < ApplicationController
  before_action :authenticate

  private

  def authenticate
    auth_token = request.headers['Authorization']
    current_user = User.find_by(token: auth_token)
    render json: { error: 'Not Authorized' }, status: 401 if current_user.nil?
  end
end