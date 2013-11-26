require 'nokogiri'
module New

	class VivaJaen < AbstractNew
		
		def initialize(*args)
			super
			parse_content
		end

		def self.url
			/^(((http:\/\/)?))((www\.)?)(andaluciainformacion\.es(.*))$/
		end

		private

		def parse_content
			page = Nokogiri::HTML(@body)

			content = page.css("#area_impresion article #texto_visible").text
			heading = page.css("#area_impresion article #titulo_visible").text

			if content.empty? && heading.empty?
				return false
			else
				@text = normalize(content.gsub("\n","").strip)
				@heading = normalize(heading)
			end
		end

	end

end