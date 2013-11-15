require_relative '../news_controller'

class CrawlerProcessJob
  
  @queue = :crawler_resque_job

  def self.perform(content)
  	@news_controller = NewsController.new()
    crawled_data = CrawledData.new(content)
  	@news_controller.analyze_content(crawled_data)
  end

  # wrapper class around received content from backend
  class CrawledData 

  	attr_accessor 	:base_url, :response_time, :url, :status_code,
					:mime_type, :character_set, :length, :text_content, :body,
					:location, :headers, :links, :internal_urls, :redis_options,
					:source_id, :crawl_id

	def initialize(params = {})
		params.each do |name, value|
			send("#{name}=", value == 'http://localhost:7541/' ? "diariojaen.es" : value)
		end
	end

  end
end


