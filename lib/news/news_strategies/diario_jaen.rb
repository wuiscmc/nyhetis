require 'nokogiri'

module New

	class DiarioJaen < AbstractNew
		
    def source
      "DIARIO JAEN"
    end

		def self.url
			/^(((http:\/\/)?))((www\.)?)(diariojaen\.es(.*))$/
		end

		def parse_content
			page = Nokogiri::HTML(@body)
      return false unless page.css(".pagination").text.empty?
      
      heading = page.css(".contentheading").text
      content = page.css(".article-content p").text
      if heading.empty? || content.empty?
        return false
      else
  			@heading = Normalizer.news_process(heading.gsub("\n","").strip)
  			@text = Normalizer.news_process(content)
      end
		end

	end

end
