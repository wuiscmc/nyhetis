# encoding: utf-8 
require 'sinatra'
require 'factory_girl'
require_relative '../dossier'
require_relative './factories/factories'


RSpec.configure do |config|
	config.filter_run_excluding :disable => true
  config.filter_run_excluding :type => :acceptance
end
