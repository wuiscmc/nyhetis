require 'spec_helper'

describe BagOfWords do


  describe "#retrieve_words" do 
    it "retrieves a bunch of words" do 
      words = BagOfWords.retrieve_words
      expect(words).to be_kind_of(Array)
      expect(words.first).to be_kind_of(BagOfWords::Word)
    end
  end

  describe BagOfWords::Word do 

    it "should never be empty" do 
      words = BagOfWords::Word.all
      expect(words).to be_kind_of(Array)
      word = words.first
      expect(word.text).not_to be_nil
      expect(word.text).not_to be_empty
    end

  end

end