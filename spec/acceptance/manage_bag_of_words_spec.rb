require 'spec_helper'
require_relative '../support/bag_of_words'
require_relative '../support/request'

describe 'Management of Bag of words' do 

  include_context "bag_of_words"
  include_context "request"

  before do 
    empty_bag_of_words
  end

  context "when the bag is empty" do 
    it "should not perform any search" do 
      response = get("/search")
      expect(response['crawl_started']).to be_false
    end
  end

  context "when the bag contains one word" do 
    it "should detect the news containing it" do 
      response = put("/words", {word:"word"})
      expect(response['response']).to be_true
    end
  end

end