module New

	class VivaJaen < AbstractNew
		
		def initialize(*args)
			super
			@text = parse_content
		end

		def self.url
			/^(((http:\/\/)?))((www\.)?)(vivajaen\.es(.*))$/
		end

		private

		def parse_content
			page = Nokogiri::HTML(@body)
			@text = page.css("#area_impresion").css('article').css("#texto_visible").css("p").map(&:text)*" "
		end

	end

end