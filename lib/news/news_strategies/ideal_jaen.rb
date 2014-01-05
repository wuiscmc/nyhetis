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
			image_path = get_image_path(page)
			@image = image_path.empty? ? "" : "http://www.ideal.es" + image_path
			@heading = heading#.gsub("\n","").strip
			@text = content#.gsub("\n","").strip
		end

		private 

		def get_image_path(page)
			begin
				page.css('img').reject{|img|
			     img.attribute('alt').nil? 
			   }.reject{|img| 
			     img.attribute('alt').value.empty?
			   }.reject{|img| 
			     img.attribute('src').value.include?('http') 
			   }.first.attribute('src').value
			rescue => e
				""
			end
		end

	end

end