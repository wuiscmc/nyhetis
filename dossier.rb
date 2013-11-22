require "bundler/setup"
Bundler.require(:default)
#Encoding.default_internal = 'UTF-8' 

require 'psych'
env = ENV["RACK_ENV"] || "development"
CONFIG = Psych.load_file("config/dossier.yml")[env].freeze

require './db/redis_handler'
require './lib/endpoints/dossier_endpoint'