# encoding: utf-8 
require 'fakeredis'
require 'sinatra'
require 'factory_girl'
require_relative '../dossier'
require_relative './factories/factories'


require 'psych'
words = Psych.load_file("config/words_test.yml")["words"]
words.each {|word| redis.sadd("bagwords:words",word)}

RSpec.configure do |config|
  config.filter_run_excluding :disable => true
  config.filter_run_excluding :type => :acceptance
end

