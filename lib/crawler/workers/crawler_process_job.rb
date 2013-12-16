require_relative '../../news/news_controller'

class CrawlerProcessJob
  
  @queue = :crawler_resque_job

  def self.perform(content)
  	@news_controller = NewsController.new()
    crawled_data = CrawledData.new(content)
    puts crawled_data.url
  	@news_controller.analyze_content(crawled_data)
  end

  # wrapper class around received content from backend
  class CrawledData 

  	attr_accessor 	:base_url, :response_time, :url, :status_code,
					:mime_type, :character_set, :length, :text_content, :body,
					:location, :headers, :links, :internal_urls, :redis_options,
					:source_id, :crawl_id, :error, :redirect_through

	def initialize(params = {})
		params.each do |name, value|
      value = case value 
      when 'http://localhost:7541/'
        'diariojaen.es'
      when 'http://localhost:7542/'
        'ideal.es'
      when 'http://localhost:7543/'
        'andaluciainformacion.es'
      else
        value
      end

			send("#{name}=", value)
		end
	end

  end
end



