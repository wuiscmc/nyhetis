require 'nokogiri'
module New

	class DiarioJaen < AbstractNew
		
    def source
      "DIARIO JAEN"
    end

		def self.url
			/^(((http:\/\/)?))((www\.)?)(diariojaen\.es(.*))$/
		end

		def parse_content
			page = Nokogiri::HTML(@body)
      return false unless page.css(".pagination").text.empty?
      date = page.css(".article-meta .createdate").text
      heading = page.css(".contentheading").text
      content = page.css(".article-content p").text
      if heading.empty? || content.empty?
        return false
      else
        begin
          unless date.empty? 
            # format: "Sabado, 30 de Noviembre de 2013 10:37"
            date = date.split(" ")
            month = New.translate_month(date[3].downcase)
            @date = Date.parse(date[5] +"/"+ month + "/" + date[1])
          end
        rescue 
          @date = ""
        end
        image_path = get_image_path(page)
        @image = image_path.empty? ? "" : "http://www.diariojaen.es" + image_path
        @heading = heading#.gsub("\n","").strip
        @text = content
      end

		end

    private 
    
    def get_image_path(page)
      begin
        page.css('.article-content img').first().attribute('src').value
      rescue => e
        ""
      end
    end

	end

end
