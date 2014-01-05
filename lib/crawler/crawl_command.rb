require_relative 'workers/crawler_process_job'
require_relative 'workers/crawler_finished_job'

class CrawlCommand

  REDIS_PREFIX = 'crawler'

  def initialize
    @websources = CONFIG["websources"] # redis.smembers("nyhetis:db:crawler:source_urls")
  end

  def active?
    !active.nil?
  end

  def status
    if active?
      'ACTIVE'
    else
      'INACTIVE'
    end
  end

  def start!
    return false if BagOfWords.empty? || active?
    lock!
    crawlers.each do |crawler|
      crawler.instance.start(crawler.base_url)
    end
    active?
  end

  private

  def instance(options)
    host = CONFIG['database']['host']
    port = CONFIG['database']['port']

    Cobweb.new(
      :processing_queue => "CrawlerProcessJob",  
      :crawl_finished_queue => "CrawlerFinishedJob", 
      :valid_mime_types => ["text/html"],
      :redis_options => {host: host, port: port},
      :direct_call_process_job => true,
      :obey_robots => true,
      :internal_urls => options['internal_urls']
    ) 
  end

  def active
    redis.get("#{REDIS_PREFIX}:crawling")
  end

  def lock!
    redis.set("#{REDIS_PREFIX}:crawling", true)
  end
  
  def crawlers
    @websources.map do |options|
      OpenStruct.new(base_url: options['base_url'], instance: instance(options)) 
    end
  end

end