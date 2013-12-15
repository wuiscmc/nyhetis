require_relative './encryptor'

class Token

  def initialize(params = {})
    @api_key = params[:api_key]
    @user = params[:user]
    @token = nil
  end

  def generate(length)
    expiration_time = expiration_time(length)
    @token = Encryptor.encrypt(session_token_data(expiration_time))
  end

  def reset
    @token = nil
  end

  def validate(session_token)
    return false if session_token.nil? || session_token.empty?
    begin
      parsed_user, time = parse_token(session_token)
      parsed_user == @user && time.to_i > time_now
    rescue
      false
    end
  end

  private

  TIME_PRECISION = 10 

  def time_now
    (Time.now.to_f.round(TIME_PRECISION) * (10 ** TIME_PRECISION)).to_i
  end

  def expiration_time(session_length)
    time_now + session_length * (10 ** TIME_PRECISION)
  end

  def parse_token(session_token)
    token = Encryptor.decrypt(session_token)
    token.split(":")
  end

  def session_token_data(expiration_time)
    "#{@user}:#{expiration_time}"
  end

end