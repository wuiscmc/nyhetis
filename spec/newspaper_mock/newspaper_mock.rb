require 'sinatra/base'
require 'psych'

class NewspaperMock

  def initialize
    config_file_path = File.expand_path('../../config/dossier.yml', File.dirname(__FILE__))
    config = Psych.load_file(config_file_path)["integration"]["newspaper_mock"]
    @port = config['port']
    @host = config['host']
  end

  def start!
    @thread = Thread.new do 
      run()
    end
  end

  def run
    mock = Sinatra.new do
        get('/') { erb :index } 
        get("/ping") { "OK" }
    end 
    mock.run!(host: @host, port: @port)
  end

  def stop!
    @thread.exit
  end
end