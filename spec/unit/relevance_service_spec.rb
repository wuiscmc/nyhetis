require 'spec_helper'

describe RelevanceService do 

  let(:relevance_service) { RelevanceService.new }
  let(:content) { FactoryGirl.build(:diario_jaen_new, :relevant, :body => "hola") }
  let(:words) { Array.new(2) { BagOfWords::Word.new(text: 'word' )} }
  subject(:analysis) { relevance_service.analyze_relevance(content) }

  before do 
    BagOfWords.should_receive(:retrieve_words).and_return(words)
  end

  describe "#analyze_relevance" do 
    
    context "when the new is relevant" do 
      before do 
        RelevanceCalculator.any_instance.should_receive(:calculate_relevance).and_return(true)   
      end
      it { should be_true }
    end

    context "when the new is not relevant" do 
      before do 
        RelevanceCalculator.any_instance.should_receive(:calculate_relevance).and_return(false)
      end
      it { should be_false }
    end
  end

end