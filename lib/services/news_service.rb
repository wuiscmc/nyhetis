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

		if concrete_new.relevant?
			concrete_new.save
		end

		concrete_new
	end

	def persist(new)
		new.save
	end

	def find_all_news
		NewsStrategyFactory.find_all
	end

end