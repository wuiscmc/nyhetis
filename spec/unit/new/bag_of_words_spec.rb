# encoding: utf-8
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

    describe "#normalize" do 
      it "should normalize the best before comparison text" do
          word = BagOfWords::Word.new(text: "HÓlá")
          text_to_compare = "hola"
          expect(word.in?(text_to_compare)).to be_true
      end

      it "should match complex words and text" do
        examples.each do |word, text|
          word = BagOfWords::Word.new(text: word)
          expect(word.in?(text)).to be_true
        end
      end

    end

  end

  def examples
    { 
      "hÖLå" => '!...^^¿¿??CocaCOLA!. hóLÁ -. 12asdÅSDFdfx asSE2 *.. hehe',
      "UNivErsidad   De JaÉn" => "Vida mia, tu serías mucho más facil sin examenes de la Universidad de Jaén aka ujaen.",
      "escuela politécnica de jaén" => "Jaen TekniskaHögskolan (Escuela Politécnica de Jaén) ger till Sverige en av sina bästa elever!"
    }
  end

end