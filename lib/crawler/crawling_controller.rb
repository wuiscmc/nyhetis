require_relative 'crawl_command'

class CrawlingController

    def crawl_newspapers
      crawl_command.start! 
    end

    def crawl_active
      crawl_command.status()
    end

    private

    def crawl_command
      @crawl_command ||= CrawlCommand.new
    end

end