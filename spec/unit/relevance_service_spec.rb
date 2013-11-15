require 'spec_helper'

describe RelevanceService do 

  let(:relevance_service) { RelevanceService.new }

  let(:content) { FactoryGirl.build(:diario_jaen_new, :relevant, :body => "hola") }

  let(:words) { FactoryGirl.build_list(:word, 2) }

  describe "#analyze_relevance" do 
    
    it "should calculate the relevance of a new" do 
      RelevanceCalculator.any_instance.should_receive(:calculate_relevance).and_return(true)
      BagOfWords.should_receive(:retrieve_words).and_return(words)
      result = relevance_service.analyze_relevance(content)
      expect(result).to be_true
    end

  end

end