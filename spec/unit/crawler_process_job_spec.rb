require 'spec_helper'

describe CrawlerProcessJob do 

	describe "#perform" do 

		let(:relevant_data) { FactoryGirl.attributes_for(:crawled_data, :relevant) }
		let(:irrelevant_data) { FactoryGirl.attributes_for(:crawled_data, :irrelevant) }

		it "process any website" do
			new = CrawlerProcessJob.perform(url: "www.whatever.ku", body: "alkdfjkasldf")
			expect(new.valid?).to be_false
			expect(new.relevance).to be_false
		end
		
		it "ignores irrelevant news from selected feeds" do
			new = CrawlerProcessJob.perform(irrelevant_data)
			expect(new.valid?).to be_true
			expect(new.relevance).to be_false
		end

		it "detects relevant news from selected feeds" do
			new = CrawlerProcessJob.perform(relevant_data)
			expect(new.valid?).to be_true
			expect(new.relevance).to be_true
		end

	end


end