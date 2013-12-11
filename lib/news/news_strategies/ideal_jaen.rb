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
			date = page.css(".grouphead .date").text
			return false if heading.empty? && content.empty?
			unless date.empty? 
				begin
					date = d.split(" ")
					month = New.transate_month(d[2].downcase)
					@date = Date.parse(d[4] + "/" + month + "/" + d[0])
				rescue 
					@date = ""
				end
			end
			@heading = Normalizer.news_process(heading.gsub("\n","").strip)
			@text = Normalizer.news_process(content.gsub("\n","").strip)
		end

	end

end