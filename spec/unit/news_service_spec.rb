# encoding: utf-8 
require 'spec_helper'

describe NewsService do 

	let(:relevance_command) { RelevanceCommand.new }
	let(:news_repository) { double('news_repository') }
	let(:news_service) { NewsService.new(relevance_command: relevance_command, news_repository: news_repository) }


	before do 
		NewsStrategyFactory.should_receive(:build_new).with(crawled_data).and_call_original
	end

	context "when crawler downloads a new" do 

		context "when is relevant" do 
			let(:crawled_data) { FactoryGirl.build(:crawled_data, :relevant) } 
			
			before do 
				news_repository.should_receive(:save_new)
			end

			it "should be persisted" do 
				news_service.analyze_content(crawled_data)
			end
		end

		context "when is not relevant" do 
			let(:crawled_data) { FactoryGirl.build(:crawled_data, :irrelevant) } 
			before do 
			 	news_repository.should_not_receive(:save_new)
			end
			it "should not be persisted" do 
				news_service.analyze_content(crawled_data)
			end
		end

	end

end