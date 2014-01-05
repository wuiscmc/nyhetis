# encoding: utf-8 
ENV['RACK_ENV'] = 'test'

#require 'fakeredis'
require 'sinatra'
require 'factory_girl'

require_relative '../dossier'
require_relative './factories/factories'

RSpec.configure do |config|
  
  config.before(:each) do 
    words_file = File.expand_path('../config/words_test.yml', File.dirname(__FILE__))
    words = Psych.load_file(words_file)["words"]
    words.each {|word| redis.sadd(BagOfWords::REDIS_PREFIX, word)}
  end
  
  config.after(:each) do 
    redis.del(BagOfWords::REDIS_PREFIX)
  end

  config.after(:suite) do 
    redis.flushall
  end

  config.filter_run_excluding :disable => true
  config.filter_run_excluding :type => :acceptance
end
