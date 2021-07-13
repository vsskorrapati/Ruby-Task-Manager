class UserAuthenticator
  class AuthenticationError < StandardError; end

  attr_reader :user, :access_token

  def initialize(code)
    @code = code
  end

  def perform
    raise AuthenticationError if code.blank?
    raise AuthenticationError if token.try(:error).present?

    prepare_user
    @access_token = if user.access_token.present?
      user.access_token
    else
      user.create_access_token
    end
  end

  private

  def token
    @token ||= code.credentials.token
  end

  def user_data
    @user_data ||= code.info.to_h.slice(:email, :avatar_url, :name)
  end

  def prepare_user
    @user = if User.exists?(email: user_data[:email])
      User.find_by(email: user_data[:email])
    else
      User.create(user_data.merge(provider: 'google'))
    end
  end

  attr_reader :code
end
