require 'spec_helper'

describe RelevanceCalculator do 

  describe '#calculate_relevance' do 

    let(:text) { "hola holisimo" }
    
    context "the text contains any word" do 
      let(:words) { FactoryGirl.build_list(:word, 5, text: "hola") }
      let(:relevance_calculator) { RelevanceCalculator.new(words: words, text: text) }
      it { expect(relevance_calculator.calculate_relevance).to be_true }
    end

    context "the text doesnt contain any word" do 
      let(:words) { FactoryGirl.build_list(:word, 5, text: "hello") }
      let(:relevance_calculator) { RelevanceCalculator.new(words: words, text: text) }
      it { expect(relevance_calculator.calculate_relevance).to be_false }
    end

  end
  
end