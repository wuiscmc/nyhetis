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
#   it defines the dossier endpoints that are available from the client applications
class DossierEndpoint < Sinatra::Base

  def initialize(*args)
    super(args)
    @crawling_controller = CrawlingController.new
    @news_controller = NewsController.new
    @bow_controller = BagOfWordsController.new
    @authentication_controller = AuthenticationController.new
  end

  # Gives the order to submit a background job and to start the crawling process over the newspapers
  #
  # @return [Boolean] <i>response: status</i> The crawl process has started or not
  get '/search' do
    content_type :json
    status = @crawling_controller.crawl_newspapers()
    {response: status}.to_json
  end

  # Queries the crawler for its status
  #
  # @return [String] <i>response: status</i> where status is <b>ACTIVE</b> or <b>INACTIVE</b> depending on the status of the crawler
  get '/status' do 
    content_type :json
    status = @crawling_controller.crawl_active()
    {response: status}.to_json
  end

  # Queries for the news and if a query params were given filters them.
  #
  # @param [Optional<Hash>] <i>fromts: <from_date>, tots: <to_date></i> where dates format is <b>YYYY-MM-DD</b>
  # @return [Array] <i>news: <news></i>
  get '/news' do
    content_type :json
    news = @news_controller.fetch_news(params)
    {news: news}.to_json
  end

  # Retrieves the bag of words adding a word
  #
  # @return [Array] <i>words: <words></i>
  get "/words" do 
    content_type :json
    words = @bow_controller.fetch_words()
    {words: words}.to_json
  end

  # Updates the bag of words adding a word requires to send a form with www-url-form-encoded 
  # @param [String] word: <word> word to be deleted
  # @return [Boolean] <i>response: <succeeed></i> The word was added or not
  put "/words" do 
    content_type :json
    success = @bow_controller.add_word(params[:word])
    {response: success}.to_json
  end

  # Updates the bag of words deleting a word
  #
  # @return [Boolean] <i>response: <success></i> The delete was sucessful or failed
  delete "/words" do 
    content_type :json
    success = @bow_controller.delete_word(params[:word])
    {response: success}.to_json
  end

  # Creates a session in the system for a user
  #
  # @return [String] <i>response: <session_id></i> the session_id that should be sent in every internal request. 
  post '/session' do 
    begin
      content_type :json
      session_id = @authentication_controller.create_session(params)
      {session: session_id}.to_json
    rescue AuthenticationFailedError
      halt 401, headers, {code: 401, message: 'Unauthorized'}.to_json
    end
  end

  # Logs out a user from the system by reseting his session
  #
  # @return [String] <i>response: <session_id></i> empty session id string
  delete '/session' do 
    content_type :json
    session_id = @authentication_controller.delete_session(params)
    {session: session_id}.to_json
  end

  # Heartbeat that will provide with information about whether the core is working or not
  # 
  #
  get "/ping" do 
    "PONG"
  end

  before '/words' do 
    begin
      @authentication_controller.validate_session({
        user: env['HTTP_AUTH_USER'], 
        session_id: env['HTTP_SESSION_ID']
      })
    rescue AuthenticationFailedError => e
      halt 403, headers, {code: 403, message: 'Unauthorized'}.to_json
    end
  end

end



