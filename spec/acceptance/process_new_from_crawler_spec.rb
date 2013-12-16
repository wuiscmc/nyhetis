require 'spec_helper'
require_relative '../support/request'
require_relative '../support/bag_of_words'
require_relative '../newspaper_mock/newspaper_mock'
require 'pry'
describe "Search for news", acceptance: true do 

    include_context "request"
    include_context "bag_of_words"
        
    let(:diariojaen) { NewspaperMock.new(:diariojaen) }
    let(:idealjaen){ NewspaperMock.new(:idealjaen) }
    let(:vivajaen){ NewspaperMock.new(:vivajaen) }

    before do 
        initialize_bag_of_words
        diariojaen.start!
        idealjaen.start!
        vivajaen.start!
    end

	it "should detect the relevant news from given sources" do 
        get('/search')
        sleep 15
        news = get('/news')
        binding.pry
        expect(news['count']).to eq(3)
	end

    after do 
        diariojaen.stop!
        idealjaen.stop!
        vivajaen.stop!
    end

end
