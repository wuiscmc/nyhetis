require 'json'
require 'psych'
require 'typhoeus'
require 'spec_helper'

describe DossierEndpoint, integration: true do 
  
  before do 
    @config = Psych.load_file("config/dossier.yml")["integration"].freeze
  end

  context "GET /api/v1/news" do
    let(:endpoint) { url("/api/v1/news") } 
    subject{ Typhoeus.get(endpoint) }
    it { should be_success }

  end

  context "GET /api/v1/search" do
    let(:endpoint) { url("/api/v1/search") } 
    subject{ Typhoeus.get(endpoint) }
    it { should be_success }
  end

  context "PUT /api/v1/words" do 
    let(:endpoint) { url("/api/v1/words") } 
    subject{ Typhoeus.put(endpoint) }
    it { should be_success }
  end

  def url(endpoint)
    __url = "#{@config["server"]["host"]}:#{@config["server"]["port"]}"
    "#{__url}#{endpoint}"
  end

end