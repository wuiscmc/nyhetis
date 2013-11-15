require "bundler/setup"
Bundler.require(:default)

require 'psych'
env = ENV["RACK_ENV"] || "development"
CONFIG = Psych.load_file("config/dossier.yml")[env].freeze

require './lib/endpoints/dossier_endpoint'

map('/api/v1') do
  run DossierEndpoint
end