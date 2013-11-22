require 'json'
require 'psych'
require 'typhoeus'
require 'spec_helper'

describe "Search for news", type: :acceptance do 

    before do 
        @config = Psych.load_file("config/dossier.yml")["integration"].freeze
        @url = "#{@config["server"]["host"]}:#{@config["server"]["port"]}"
    end

	it "should detect the relevant news from given sources" do 
        # Given there is a newspaper with a Universidad de Jaen new
        puts "Checking mock newspaper running..."
        mock_server_running?

        # When the user requests to update the news in the cache
        puts "Sending request to server..."
        response = Typhoeus.get(url("/search")) 
        sleep 10 # since the request performs an asynchronous call, we need to give time to the server to process it.

        # Then the system should return the newly added news upon request
        puts "Requesting news..."
        response = Typhoeus.get(url("/news"))

        news = JSON.parse!(response.body)
        expect(news).to be_kind_of(Array)

        news.each do |new|
            expect(new).to have_key("text")
            expect(new).to have_key("heading")
        end

	end

    def mock_server_running?
        newspaper_mock_url = "#{@config["newspaper_mock"]["host"]}:#{@config["newspaper_mock"]["port"]}" 
        ping = Typhoeus.get(newspaper_mock_url + "/ping")
        raise "Mock server isnt active: ruby #{__FILE__}/diariojaen_mock.rb" unless ping.body == "OK"
    end

    def url(endpoint)
        __url = "#{@config["server"]["host"]}:#{@config["server"]["port"]}"
        __url + "/api/v1" + endpoint
    end

end
