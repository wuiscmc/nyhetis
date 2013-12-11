require 'spec_helper'
require_relative '../support/request'
require_relative '../support/bag_of_words'
require_relative '../support/newspaper_mock'

describe "Search for news", acceptance: true do 

    include_context "request"
    include_context "bag_of_words"
    include_context "newspaper_mock"

    before do 
        initialize_bag_of_words
    end

	it "should detect the relevant news from given sources" do 
        get('/search')
        sleep 10
        news = get('/news')
        expect(news['count']).to eq(1)
	end


end
