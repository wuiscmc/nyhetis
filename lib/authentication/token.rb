require_relative './encryptor'

class Token

  def initialize(user)
    @user = user
    @token = nil
  end

  def generate(expiration_time)
    @token ||= Encryptor.encrypt(session_token_data(expiration_time))
  end

  def reset
    @token = nil
  end

  def validate(session_token)
    return false if session_token.nil? || session_token.empty?
    begin
      parsed_user, time = parse_token(session_token)
      parsed_user == @user && time.to_i > Time.now.to_i
    rescue
      false
    end
  end

  private

  def parse_token(session_token)
    token = Encryptor.decrypt(session_token)
    token.split(":")
  end

  def session_token_data(expiration_time)
    "#{@user}:#{@expiration_time}"
  end

end