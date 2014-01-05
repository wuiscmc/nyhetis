require 'json'
require 'psych'
require 'typhoeus'
require 'spec_helper'

describe DossierEndpoint, integration: true do 

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
    subject{ Typhoeus.put(endpoint).code }
    it { should == 403 }
  end

  context "DELETE /api/v1/words" do 
    let(:endpoint) { url("/api/v1/words") } 
    subject{ Typhoeus.delete(endpoint).code }
    it { should == 403 }
  end

  context "GET /api/v1/words" do 
    let(:endpoint) { url("/api/v1/words") } 
    subject{ Typhoeus.get(endpoint).code }
    it { should == 403 }
  end

  def url(endpoint)
    __url = "#{CONFIG["server"]["host"]}:#{CONFIG["server"]["port"]}"
    "#{__url}#{endpoint}"
  end

end