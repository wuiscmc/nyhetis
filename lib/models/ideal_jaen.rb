require 'nokogiri'
module New

	class IdealJaen < AbstractNew
		
		def initialize(*args)
			super
			parse_content
		end

		def self.url
			/^(((http:\/\/)?))((www\.)?)(ideal\.es(.*))$/
		end
	
		private

		def parse_content
			page = Nokogiri::HTML(@body)
			heading = page.css(".zonadecontenidos h1.headline").text
			content = page.css(".zonadecontenidos .articulo .text").text
			return false if heading.empty? && content.empty?
			@heading = normalize(heading.gsub("\n","").strip)
			@text = normalize(content.gsub("\n","").strip)
		end

	end

end