class CrawlerFinishedJob
  
  @queue = :crawler_finished_job

  def self.perform(statistics)    
    redis.del("crawler:crawling")
  end
end
