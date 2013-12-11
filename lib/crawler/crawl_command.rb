require_relative 'workers/crawler_process_job'
require_relative 'workers/crawler_finished_job'

class CrawlCommand

  REDIS_PREFIX = 'crawler'

  def initialize
    @urls = CONFIG["websources"] # redis.smembers("nyhetis:db:crawler:source_urls")
    @active = redis.get("#{REDIS_PREFIX}:crawling") 
  end

  def active?
    !active.nil?
  end

  def start!
    return false if BagOfWords.empty?
    lock!
    crawlers.each do |crawler|
      crawler.instance.start(crawler.url)
    end
    active?
  end

  private

  def instance(url)
    Cobweb.new(
      :processing_queue => "CrawlerProcessJob",  
      :crawl_finished_queue => "CrawlerFinishedJob", 
      :valid_mime_types => ["text/html"],
      :direct_call_process_job => true,
      :internal_urls => ["#{url}/*"]
    ) 
  end

  def active
    redis.get("#{REDIS_PREFIX}:crawling")
  end

  def lock!
    @active = redis.set("#{REDIS_PREFIX}:crawling", true)
  end
  
  def crawlers
    @urls.map{|url| OpenStruct.new(url: url, instance: instance(url)) }
  end

end