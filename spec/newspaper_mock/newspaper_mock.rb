require 'sinatra/base'
require 'psych'

class NewspaperMock

  def initialize(newspaper = :diariojaen)
    config_file_path = File.expand_path('../../config/dossier.yml', File.dirname(__FILE__))
    config = Psych.load_file(config_file_path)["test"]["newspaper_mock"]
    @host = config['host']
    @newspaper = newspaper

    @port = case newspaper 
    when :diariojaen
      7541
    when :idealjaen
      7542
    when :vivajaen
      7543
    else
      7541
    end

  end

  def start!
    @thread = Thread.new do 
      run()
    end
  end

  def run
    newspaper = @newspaper
    mock = Sinatra.new do
        get('/') { erb newspaper } 
        get("/ping") { "OK" }
    end 
    mock.run!(host: @host, port: @port)
  end

  def stop!
    @thread.exit
  end
end