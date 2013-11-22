require 'nokogiri'
module New

	class IdealJaen < AbstractNew
		
		def initialize(*args)
			super
			parse_content
		end

		def self.url
			/^(((http:\/\/)?))((www\.)?)(idealjaen\.es(.*))$/
		end
	
		private

		def parse_content
			page = Nokogiri::HTML(@body)
			@heading = page.css(".zonadecontenidos").css(".art_head").css('h1.headline').map(&:text)*" "
			@text = page.css(".zonadecontenidos").css('.articulo').css(".text").css("p").map(&:text)*" "
		end

	end

end