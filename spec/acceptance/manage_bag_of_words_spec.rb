require 'spec_helper'
require_relative '../support/bag_of_words'
require_relative '../support/request'

describe 'how the system uses the bag of words' do 

  include_context "bag_of_words"
  include_context "request"

  before do 
    empty_bag_of_words
  end

  context "when the bag is empty" do 
    it "should ignore the crawl requests" do 
      response = get("/search")
      expect(response['response']).to be_false
    end
  end

  context "when the bag contains one word" do 
    it "should detect the news containing it" do 
      put("/words", {word: "word"})
      response = get("/search")
      expect(response['response']).to be_true
    end

    context "when the word is deleted" do 
      it "should stop accepting requests again" do 
        delete("/words", {word: "word"})
        response = get("/search")
        expect(response['response']).to be_false
      end
    end
  end

end