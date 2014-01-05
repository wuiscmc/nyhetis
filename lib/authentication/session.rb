require_relative './authentication_failed_error'
require_relative './token'
require_relative './user'

class Session

  SESSION_LENGTH = 900

  attr_reader :session_id

  def initialize(params = {})
    @user = params[:user]
    @pass = params[:pass]
    @session_id = params[:session_id]
    @api_key = params[:api_key]
    @token = Token.new(user: params[:user], api_key: params[:api_key])
    @expiration_time = Time.now.to_i + SESSION_LENGTH
  end

  def authenticate
    if @token.validate(@session_id) || valid_credentials?
      @session_id = @token.generate(SESSION_LENGTH)
    else
      raise AuthenticationFailedError, 'Authentication failed'
    end
  end

  def logout
    @session_id = ''
    self
  end

  def empty?
    @session_id.empty?
  end

  def to_json(*args)
    @session_id.to_json
  end

  private

  def valid_credentials?
    User.valid?(@user, @pass)
  end

end

