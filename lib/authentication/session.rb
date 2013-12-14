require_relative './authentication_failed_error'
require_relative './token'

class Session

  SESSION_LENGTH = 1500

  def initialize(params = {})
    @user = params[:user]
    @pass = params[:pass]
    @session_id = params[:session_id]
    @api_key = params[:api_key]
    @token = Token.new(params[:user])
    @expiration_time = Time.now.to_i + SESSION_LENGTH
  end

  def authenticate
    if @token.validate(@session_id) || valid_credentials?
      @session_id = @token.generate(@expiration_time)
    else
      false
    end
  end

  def logout
    @session_id = ''
    self
  end

  def to_json(*args)
    @session_id.to_json
  end

  private

  def valid_credentials?
    @user == "test" && @pass == "test"
  end

end

