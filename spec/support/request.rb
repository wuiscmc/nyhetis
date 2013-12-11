require 'json'
require 'psych'
require 'typhoeus'

shared_context "request" do 

  CONFIG_INTEGRATION = Psych.load_file("config/dossier.yml")["integration"].freeze

  def get(url)
    response = request(:get, url)
  end

  def put(url, payload)
    request_with_payload(:put, url, body: payload, headers:{'content-type' => 'application/x-www-form-urlencoded'})
  end

  def post(url)
    request(:post, url)
  end

  def delete(url)
    request(:delete, url)
  end

  private

  def request(method,url)
    response = Typhoeus.send(method, build_url(url)) 
    expect(response.body).not_to be_empty
    JSON.parse!(response.body)
  end

  def request_with_payload(method, url, payload)
    response = Typhoeus.send(method, build_url(url), payload) 
    expect(response.body).not_to be_empty
    JSON.parse!(response.body)
  end

  def build_url(path)
      __url = "#{CONFIG_INTEGRATION["server"]["host"]}:#{CONFIG_INTEGRATION["server"]["port"]}"
      __url + "/api/v1" + path
  end

end