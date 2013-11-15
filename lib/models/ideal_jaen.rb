module New

	class IdealJaen < AbstractNew
		
		def initialize(*args)
			super
			@text = parse_content
		end

		def self.url
			/^(((http:\/\/)?))((www\.)?)(idealjaen\.es(.*))$/
		end
	
		private

		def parse_content
			page = Nokogiri::HTML(@body)
			@text = page.css(".zonadecontenidos").css('.articulo').css(".text").css("p").map(&:text)*" "
		end

	end

end