require 'spec_helper'

describe CrawlCommand do 
  
  before do 
    redis.del(CrawlCommand::REDIS_PREFIX + ":crawling") 
  end

  context "when the dance begins" do 
    subject(:crawl_command) { CrawlCommand.new }
    it { should_not be_active }
  end

  context "when starts to swing" do 
    subject(:crawl_command) { CrawlCommand.new }
    before do 
      crawl_command.start!
    end

    it { should be_active }
    
    after do 
      CrawlerFinishedJob.perform({})
    end
  end

  context "when its time to go home" do 
    subject(:crawl_command) { CrawlCommand.new }
    before do
      crawl_command.start!
      CrawlerFinishedJob.perform({})
    end

    it { should_not be_active }
  end

end