require 'spec_helper'

describe RelevanceCommand do 

  let(:relevance_command) { RelevanceCommand.new }

  context "when the text contains at least one word" do 
    let(:vivajaen_new) { FactoryGirl.build(:vivajaen_new) }
    it { expect(relevance_command.calculate(vivajaen_new)).to be > 0 }
  end

  context "when the text doesnt contain any word" do 
    let(:vivajaen_new) { FactoryGirl.build(:vivajaen_new, :body => "hola") }
    it { expect(relevance_command.calculate(vivajaen_new)).to be <= 0 }
  end

  context "when the date is today" do 
    let(:new_1) { FactoryGirl.build(:vivajaen_new, :date => Date.parse('2013-01-01')) }
    let(:new_2) { FactoryGirl.build(:vivajaen_new, :date => nil) }
    before do 
      mock_today = Date.parse('2013-01-03')
      Date.stub(:today).and_return(mock_today)
    end
    it "blabla" do 
      puts relevance_command.calculate(new_1)
      puts relevance_command.calculate(new_2)
    end
  end

end