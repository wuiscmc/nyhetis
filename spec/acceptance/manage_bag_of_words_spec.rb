require 'spec_helper'
require_relative '../support/bag_of_words'
require_relative '../support/request'

describe 'the impact of the bag of words' do 

  include_context "bag_of_words"
  include_context "request"

  before do 
    empty_bag_of_words
  end
  
  context "when the user is not logged in" do 
    it "should ignore the request" do 
      response = get("/words")
      expect(response['code']).to eq(401)
    end
  end

  context "when the user is logged in" do 
    let(:session_id) {login_user}

    context "when the bag is empty" do 
      it "should ignore the crawl requests" do 
        response = get("/search")
        expect(response['response']).to be_false
      end
    end

    context "when the bag contains one word" do 
      it "should detect the news containing it" do 
        put("/words", body: {word: "word"}, headers:{'Session-Id' => session_id, 'User' => test_user.user})
        response = get("/search")
        expect(response['response']).to be_true
      end

      context "when the word is deleted" do 
        it "should stop accepting requests again" do 
          delete("/words", body: {word: "word"}, headers:{'Session-Id' => session_id, 'User' => test_user.user})
          response = get("/search")
          expect(response['response']).to be_false
        end
      end
    end
  end
end