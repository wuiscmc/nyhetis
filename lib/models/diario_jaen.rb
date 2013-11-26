module New

	class DiarioJaen < AbstractNew
		
		def initialize(*args)
			super
			parse_content
		end

		def self.url
			/^(((http:\/\/)?))((www\.)?)(diariojaen\.es(.*))$/
		end

		private 

		def parse_content
			page = Nokogiri::HTML(@body)
      return false unless page.css(".pagination").text.empty?
      heading = page.css(".contentheading").text
      content = page.css(".article-content p").text
      return false if heading.empty? || content.empty?
      heading = heading.gsub("\n","").strip
			@heading = normalize(heading)
			@text = normalize(content)
		end

	end

end
