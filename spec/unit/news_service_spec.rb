# encoding: utf-8 

require 'spec_helper'


describe NewsService do 

	let(:relevance_service) { double('relevance_service') }
	let(:news_service) { NewsService.new(relevance_service: relevance_service) }
	
	describe '#analyze_content' do 

		before do 
			NewsStrategyFactory.should_receive(:find_strategy).with(crawled_data).and_call_original
		end

		context "when crawler downloads a new" do 

			let(:crawled_data) { FactoryGirl.build(:crawled_data, :valid) } 
			
			before do
				relevance_service.should_receive(:analyze_relevance)
			end

			context "and is relevant" do 
				let(:crawled_data) { FactoryGirl.build(:crawled_data, :relevant) } 
				subject(:new) { news_service.analyze_content(crawled_data) }
				it { should be_persisted }
			end

			context "and is not relevant" do 
				let(:crawled_data) { FactoryGirl.build(:crawled_data, :irrelevant) } 
				subject(:new) { news_service.analyze_content(crawled_data) }
				it { should_not be_persisted }
			end

		end

		context "when crawler downloads something else" do 
			
			let(:crawled_data) { FactoryGirl.build(:crawled_data, :invalid) }

			before do 
				relevance_service.should_not_receive(:analyze_relevance)
			end

			it "should not analyze it" do 				
				news_service.analyze_content(crawled_data)
			end
		end
	end
end