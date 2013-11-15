require 'sinatra/base'
require_relative '../crawler_resque'

class DossierEndpoint < Sinatra::Base

  get '/search' do
      puts CONFIG["websources"].first
#      CrawlerResque.start(CONFIG["websources"].first)
      "OK"
  end

  get '/eat/:food' do
      
      "Put #{params['food']} in fridge to eat later."
  end

end