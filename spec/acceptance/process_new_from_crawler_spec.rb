require 'spec_helper'
require_relative '../support/request'
require_relative '../support/bag_of_words'
require_relative '../newspaper_mock/newspaper_mock'

# Specification for "Search for news"
# it requires some workers to be up and running,
# to enable 10 workers that will listen to the events: 
#
# rake resque:workers RACK_ENV=test RESQUE_WORKER=true TERM_CHILD=1 QUEUE=cobweb_crawl_job,crawler_resque_job,crawler_finished_job COUNT=10
#
describe "Search for news", acceptance: true do 
    include_context "request"
    include_context "bag_of_words"
    
    let(:diariojaen){ NewspaperMock.new(:diariojaen) }
    let(:idealjaen){ NewspaperMock.new(:idealjaen) }
    let(:vivajaen){ NewspaperMock.new(:vivajaen) }

    before do 
        diariojaen.start!
        idealjaen.start!
        vivajaen.start!
        get('/search')
        sleep(10)
    end        

    context "when no filter is given" do 
    	it "should detect the relevant news" do 
            news = get('/news')
            expect(news['count']).to eq(3)
    	end
    end

    context "when a filter is given" do 
        # diariojaen '2009-11-11' | idealjaen '2013-08-27' | vivajaen '2012-06-12'
        let(:fromdate) { '2012-01-01' }
        let(:todate) { '2013-01-01' }

        it "should detect the relevant news matching the filter" do 
            news = get("/news", params: { fromts: fromdate, tots: todate })
            expect(news['count']).to eq(1)
        end
    end

    after do 
        diariojaen.stop!
        idealjaen.stop!
        vivajaen.stop!
    end
end
