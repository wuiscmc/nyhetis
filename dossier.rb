require "bundler/setup"
Bundler.require(:default)
#Encoding.default_internal = 'UTF-8' 

require 'psych'
CONFIG = Psych.load_file("config/dossier.yml")[ENV['RACK_ENV']].freeze
require_relative 'db/redis_handler'
require_relative 'lib/api/dossier_endpoint'