require 'sinatra/base'
require 'psych'
config = Psych.load_file('../../config/dossier.yml')["integration"]["newspaper_mock"]
my_app = Sinatra.new do
    get('/') { erb :index } 
    get("/ping") { "OK" }
end 
my_app.run!(port: config["port"], host: config["host"])
