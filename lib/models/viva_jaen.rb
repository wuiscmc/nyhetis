require 'nokogiri'
module New

	class VivaJaen < AbstractNew
		
		def initialize(*args)
			super
			parse_content
		end

		def self.url
			/^(((http:\/\/)?))((www\.)?)(vivajaen\.es(.*))$/
		end

		private

		def parse_content
			page = Nokogiri::HTML(@body)
			@heading = page.css("#area_impresion").css('article').css('#titulo_visible').map(&:text)*" "
			@text = page.css("#area_impresion").css('article').css("#texto_visible").css("p").map(&:text)*" "
		end

	end

end