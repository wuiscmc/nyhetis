require 'nokogiri'

module New

	class IdealJaen < AbstractNew
		
		def source
			"IDEAL JAEN"
		end

		def self.url
			/^(((http:\/\/)?))((www\.)?)(ideal\.es(.*))$/
		end
	
		def parse_content
			page = Nokogiri::HTML(@body)
			heading = page.css(".zonadecontenidos h1.headline").text
			content = page.css(".zonadecontenidos .articulo .text").text
			date = page.css(".art_head .date").text
			return false if heading.empty? && content.empty?
			unless date.empty? 
				begin
					@date = Date.strptime(date.split(" ")[0], "%d.%m.%y")
				rescue 
					@date = ""
				end
			end
			@heading = Normalizer.news_process(heading.gsub("\n","").strip)
			@text = Normalizer.news_process(content.gsub("\n","").strip)
		end

	end

end