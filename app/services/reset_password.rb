require 'token_processor'

class ResetPassword
  prepend SimpleCommand

  attr_reader :token, :password, :password_confirmation

  def initialize(params)
    @token = params[:token]
    @password = params[:password]
    @password_confirmation = params[:password_confirmation]
  end

  def call
    user, _ = TokenProcessor.decode_reset_password_token(token)

    user.password = password
    user.password_confirmation = password_confirmation
    user.save!
    true
  rescue JWT::ExpiredSignature
    errors.add(:base, "Token is expired")
    nil
  rescue JWT::InvalidSubError, JWT::DecodeError
    errors.add(:base, "Token is invalid")
    nil
  rescue ActiveRecord::RecordNotFound
    errors.add(:base, "Can not find the user")
    nil
  rescue ActiveRecord::RecordInvalid
    errors.add(:base, "New password is invalid")
    nil
  end

  def error
    errors[:base].try(:first)
  end
end
