require 'spec_helper'

describe CrawlerProcessJob do 

		let(:relevant_data) { FactoryGirl.attributes_for(:crawled_data, :relevant) }
		let(:irrelevant_data) { FactoryGirl.attributes_for(:crawled_data, :irrelevant) }

		context "when it downloads a website" do
			
			context "when it is not a new" do 
				it "should not parse it" do
					new = CrawlerProcessJob.perform(url: "www.whatever.ku", body: "alkdfjkasldf")
					expect(new.valid?).to be_false
					expect(new.relevant?).to be_false
				end
			end

			context "when it is a new" do 

				it "should detect relevant news" do
					new = CrawlerProcessJob.perform(relevant_data)
					expect(new.valid?).to be_true
					expect(new.relevant?).to be_true
				end
				
				it "should ignore irrelevant news" do
					new = CrawlerProcessJob.perform(irrelevant_data)
					expect(new.valid?).to be_true
					expect(new.relevant?).to be_false
				end
			end
		end




end