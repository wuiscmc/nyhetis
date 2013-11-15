# encoding: utf-8 

require 'spec_helper'


describe NewsService do 

	let(:relevance_service) { double('relevance_service') }
	let(:news_service) { NewsService.new(relevance_service: relevance_service) }

	describe '#analyze_content' do 

		context "content is a New" do 

			let(:crawled_data) { FactoryGirl.build(:crawled_data, :valid) } 

			it "analyzes the data" do 
				NewsStrategyFactory.should_receive(:find_strategy).with(crawled_data).and_call_original
				relevance_service.should_receive(:analyze_relevance)
				news_service.analyze_content(crawled_data)
			end

		end

		context "content is not a New" do 
			
			let(:crawled_data) { FactoryGirl.build(:crawled_data, :invalid) }

			it "doesnt analyze the data" do 
				NewsStrategyFactory.should_receive(:find_strategy).with(crawled_data).and_call_original
				relevance_service.should_not_receive(:analyze_relevance)
				news_service.analyze_content(crawled_data)
			end
		end
	end


end