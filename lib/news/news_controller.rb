require_relative 'news_service'
require_relative 'news_repository'

class NewsController

	def analyze_content(content)
		news_service.analyze_content(content)
	end

	def fetch_news()
		news_service.fetch_news()
	end

	private

	def news_service
		@news_service ||= NewsService.new({
			relevance_command: RelevanceCommand.new,
			news_repository: NewsRepository.new
		})
	end


end
