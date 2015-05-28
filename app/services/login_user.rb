require 'token_processor'

class LoginUser
  prepend SimpleCommand

  attr_reader :email, :password

  def initialize(params)
    @email = params[:email]
    @password = params[:password]
  end

  def call
    if user && user.authenticate(password)
      TokenProcessor.encode_auth_token(user)
    else
      errors.add(:base, "Invalid email or password")
      nil
    end
  end

  def error
    errors[:base].try(:first)
  end

  private

  def user
    @user ||= User.find_by(email: email)
  end
end
