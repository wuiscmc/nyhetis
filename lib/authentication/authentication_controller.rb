require_relative './session'

class AuthenticationController

  def create_session(params = {})
    session = Session.new({
      user: params[:user],
      pass: params[:password],
      api_key: params[:api_key]
    })
    
    session.authenticate
  end

  def delete_session(params = {})
    session = Session.new({
      user: params[:user],
      session_id: params[:session_id],
      api_key: params[:api_key]
    })
    session.logout
  end

  def validate_session(params)
    session = Session.new({
      user: params[:user],
      session_id: params[:session_id],
      api_key: params[:api_key]
    })
    session.authenticate
  end

end