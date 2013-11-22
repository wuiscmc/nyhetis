require 'sinatra/base'
require_relative '../crawler_resque'

class DossierEndpoint < Sinatra::Base

  def initialize(*args)
    super(args)
    @news_controller = NewsController.new
  end


  get '/search' do
    CrawlerResque.start(CONFIG["websources"].first)
  end

  get '/news' do
      news = @news_controller.find_all_news
      news.to_json
  end

end