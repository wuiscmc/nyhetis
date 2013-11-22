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
			@heading = normalize(page.css(".contentheading").map(&:text)*" ")
			@text = normalize(page.css(".article-content").css('p').map(&:text)*" ")
		end

	end

end