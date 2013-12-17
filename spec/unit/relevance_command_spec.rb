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

end