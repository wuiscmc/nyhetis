require 'sinatra/base'
require 'json'
require_relative '../bag_of_words/bag_of_words_controller'
require_relative '../crawler/crawling_controller'
require_relative '../news/news_controller'
require_relative '../authentication/authentication_controller'

# Main endpoint of the application
# 
# author: Luis Carlos Mateos 
# 
# description: 
#   it defines the dossier endpoints that are available from the 
#   client applications

class DossierEndpoint < Sinatra::Base

  def initialize(*args)
    super(args)
    @crawling_controller = CrawlingController.new
    @news_controller = NewsController.new
    @bow_controller = BagOfWordsController.new
    @authentication_controller = AuthenticationController.new
  end

  # GET /search
  # gives the order to submit a background job and to start
  # the crawling process over the newspapers
  # returns 
  # => response: whether the crawl process has started or not
  get '/search' do
    content_type :json
    status = @crawling_controller.crawl_newspapers()
    {response: status}.to_json
  end

  # GET /news
  # returns a structure with 
  # => payload: the relevant news crawled
  # => count : is the number of elements 
  get '/news' do
    content_type :json
    news = @news_controller.fetch_news(params)
    {count: news.size, payload: news}.to_json
  end

  # GET /words
  # modifies the bag of words adding a word
  # => response: the list of words 
  get "/words" do 
    content_type :json
    words = @bow_controller.fetch_words()
    {response: words}.to_json
  end

  # PUT /words
  # modifies the bag of words adding a word
  # requires to send a form with www-url-form-encoded 
  # => response: true/false depending on whether the word was added or not
  put "/words" do 
    content_type :json
    success = @bow_controller.add_word(params[:word])
    {response: success}.to_json
  end

  # DELETE /words
  # modifies the bag of words deleting a word
  # => response: whether the delete was sucessful or failed
  delete "/words" do 
    content_type :json
    success = @bow_controller.delete_word(params[:word])
    {response: success}.to_json
  end

  # POST /session
  # creates a session in the system for a user
  # => session: the session_id that should be sent in every internal request. 
  post '/session' do 
    content_type :json
    session_id = @authentication_controller.create_session(params)
    {session: session_id}.to_json
  end

  # DELETE /session
  # logs out a system from the user by reseting his session
  # => session: the session_id after the request - empty string
  delete '/session' do 
    content_type :json
    session_id = @authentication_controller.delete_session(params)
    {session: session_id}.to_json
  end

  # GET /ping
  # this endpoint is the heartbeat that will
  # provide with information about whether the 
  # core is working or not
  get "/ping" do 
    "PONG"
  end

  before '/words' do 
    @authentication_controller.validate_session({
      user: env['HTTP_USER'], 
      session_id: env['HTTP_SESSION_ID']
    })
  end

  error AuthenticationFailedError do 
    halt 401, {'Content-Type' => 'application/json'}, {code: 401, message: 'unauthorized!'}.to_json
  end

end



