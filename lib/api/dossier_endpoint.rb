require 'sinatra/base'
require 'json'
require_relative '../bag_of_words/bag_of_words_controller'
require_relative '../crawler/crawling_controller'
require_relative '../news/news_controller'

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
  end

  # GET /search
  # gives the order to submit a background job and to start
  # the crawling process over the newspapers
  # returns 
  # => crawl_started: whether the crawl process has started or not
  get '/search' do
    content_type :json
    status = @crawling_controller.crawl_newspapers()
    {crawl_started: status}.to_json
  end

  # GET /news
  # returns a structure with 
  # => payload: the relevant news crawled
  # => count : is the number of elements 
  get '/news' do
    content_type :json
    news = @news_controller.fetch_news()
    {count: news.size, payload: news}.to_json
  end

  # PUT /words
  # modifies the bag of words adding a word
  # requires to send a form with www-url-form-encoded 
  put "/words" do 
    content_type :json
    success = @bow_controller.add_word(params[:word])
    {response: success}.to_json
  end

  # this endpoint is the heartbeat that will
  # provide with information about whether the 
  # core is working or not
  get "/ping" do 
    "PONG"
  end

end
