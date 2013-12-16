require_relative 'news_strategies/news_strategy_factory'

class NewsService

	def initialize(attributes)
		@relevance_command = attributes[:relevance_command]
		@news_repository = attributes[:news_repository]
	end

	def analyze_content(content)
		concrete_new = NewsStrategyFactory.build_new(content)
		
		if concrete_new.valid?
			concrete_new.relevance = @relevance_command.calculate(concrete_new)
			if concrete_new.relevant?
				@news_repository.save_new(concrete_new) 
			end
		end

		concrete_new
	end

	def fetch_news(params = {})
		@news_repository.fetch_news(params)
	end

end