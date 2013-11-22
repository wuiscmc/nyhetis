require 'spec_helper'

describe RelevanceCalculator do 

  describe '#calculate_relevance' do 

    let(:text) { "hola holisimo" }
    
    context "when the text contains at least one word" do 
      let(:words) { Array.new(5){ BagOfWords::Word.new(text: 'hola')} }
      let(:relevance_calculator) { RelevanceCalculator.new(words: words, text: text) }
      it { expect(relevance_calculator.calculate_relevance).to be_true }
    end

    context "when the text doesnt contain any word" do 
      let(:words) { Array.new(5){ BagOfWords::Word.new(text: 'hello')} }
      let(:relevance_calculator) { RelevanceCalculator.new(words: words, text: text) }
      it { expect(relevance_calculator.calculate_relevance).to be_false }
    end

  end
  
end