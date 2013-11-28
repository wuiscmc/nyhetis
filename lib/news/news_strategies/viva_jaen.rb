require 'nokogiri'

module New

	class VivaJaen < AbstractNew
		
		def source
			"VIVA JAEN"
		end

		def self.url
			/^(((http:\/\/)?))((www\.)?)(andaluciainformacion\.es(.*))$/
		end

		def parse_content
			page = Nokogiri::HTML(@body)
			content = page.css("#area_impresion article #texto_visible").text
			heading = page.css("#area_impresion article #titulo_visible").text
			if content.empty? && heading.empty?
				return false
			else
				@text = Normalizer.news_process(content.gsub("\n","").strip)
				@heading = Normalizer.news_process(heading)
			end
		end

	end

end