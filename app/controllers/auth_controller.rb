class AuthController < ApplicationController
  skip_before_action :authenticate

  def login
    command = LoginUser.call(login_params)

    if command.success?
      render json: {
        data: {
          token: command.result
        }
      }
    else
      render json: {error: command.error}, status: :unauthorized
    end
  end

  def reset_password
    command = ResetPassword.call(reset_password_params)

    if command.success?
      render json: {data: 'OK'}
    else
      render json: {error: command.error}, status: :unprocessable_entity
    end
  end

  private

  def login_params
    params.require(:data).permit(:email, :password)
  end

  def reset_password_params
    params.require(:data).permit(:token, :password, :password_confirmation)
  end
end
