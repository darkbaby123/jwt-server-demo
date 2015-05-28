class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session

  before_action :authenticate

  attr_reader :current_user

  def authenticate
    command = AuthenticateUser.call(get_auth_token)
    if command.success?
      @current_user = command.result
    else
      render json: {error: command.error}, status: :unauthorized
      false
    end
  end

  private

  def get_auth_token
    # Authorization: "Bearer <your-token>"
    auth_header = request.headers['Authorization']
    auth_header.split(' ').last
  end
end
