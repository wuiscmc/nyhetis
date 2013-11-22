require_relative 'workers/crawler_process_job'
require_relative 'workers/crawler_finished_job'

class CrawlerResque

  def self.start(url)

    cobweb = Cobweb.new(
      :processing_queue => "CrawlerProcessJob",  
      :crawl_finished_queue => "CrawlerFinishedJob", 
      :internal_urls => ["#{url}/*"]
    ) 

    cobweb.start(url) 
    true
  end
end