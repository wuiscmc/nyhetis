require 'json'
require 'psych'
require 'typhoeus'
shared_context "request" do 

  def get(url, params = {})
    request(:get, url, params)
  end

  def put(url, params = {})
    params = {headers: {}}.merge(params)
    params[:headers] = {'Content-Type' => 'application/x-www-form-urlencoded'}.merge(params[:headers])
    request(:put, url, params)
  end

  def post(url, params = {})
    request(:post, url, params)
  end

  def delete(url, params = {})
    request(:delete, url, params)
  end

  def test_user
    OpenStruct.new(user: 'test', pass: 'test', api_key: 'test')
  end

  def login_user
    response = post('/session', body: {user: test_user.user, password: test_user.pass, api_key: test_user.api_key})
    response['session']
  end

  private

  def request(method, url, params = {})
    response = Typhoeus::Request.send(method, build_url(url), params)
    expect(response.body).not_to be_empty
    JSON.parse!(response.body)
  end

  def build_url(path)
      __url = "#{CONFIG["server"]["host"]}:#{CONFIG["server"]["port"]}"
      __url + "/api/v1" + path
  end

end