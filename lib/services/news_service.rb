require_relative 'news_strategy_factory'
class NewsService

	def initialize(attributes)
		@relevance_service = attributes[:relevance_service]
	end

	def analyze_content(content)
		concrete_new = NewsStrategyFactory.find_strategy(content)
		if concrete_new.valid?			
			concrete_new.relevance = @relevance_service.analyze_relevance(concrete_new)
		end
		concrete_new
	end

	def persist(new)
		new.save
	end

end