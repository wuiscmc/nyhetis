require_relative 'models/abstract_new'
require_relative 'services/news_service'
require_relative 'services/relevance_service'

class NewsController

	def initialize()
		@relevance_service = RelevanceService.new
		@news_service = NewsService.new(relevance_service: @relevance_service)
	end

	def analyze_content(content)
		@news_service.analyze_content(content)
	end

	def save_in_history(new)
		@news_service.persist(new)
	end

end