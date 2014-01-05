module New

	class AbstractNew

		attr_accessor :relevance

		attr_accessor :url, :text, :heading, :body, :date, :image

		def initialize(attributes = {})
			attributes = {id: nil, relevance: false, text: "", url: "", heading: "", body: "", image: ""}.merge(attributes)
			@id = attributes[:id]
			@url = attributes[:url].split("?")[0]
			@body = attributes[:body]
			@relevance = attributes[:relevance]
			@text = attributes[:text]
			@heading = attributes[:heading]
			@date = attributes[:date]
			@image = attributes[:image]
			parse_content()
		end

		def source
			raise StandardError, 'Abstract method'
		end

		def valid?
			!@text.empty?
		end

		def relevant?
			@relevance > 0
		end

		def relevance=(rel)
			@relevance = rel
		end

		def self.url
			raise StandardError, "Abstract method"
		end

		def parse_content
			raise StandardError, "Abstract method"
		end

		def to_json(*args)
			attributes.to_json
		end

		def date_published
			return nil if @date.nil? 
			if @date.nil?  || (@date.is_a?(String) && @date.empty?)
				return nil
			elsif @date.is_a?(String)
				return Date.parse(@date)
			else
				return date.to_date
			end
		end

		def attributes
			{url: url, heading: heading, content: text, body: text, text: text, source: source, date: date, relevance: relevance, image: image}
		end

	end

	class NullNew < AbstractNew

		def initialize(*args); end

		def valid?
			false
		end

		def relevant?
			false
		end

	end

	def self.translate_month(month)
		month_translations = {
		 "enero" => "january" ,
		 "febrero" => "february" ,
		 "marzo" => "march" ,
		 "abril" => "april" ,
		 "mayo" => "may" ,
		 "junio" => "june" ,
		 "julio" => "july" ,
		 "agosto" => "august" ,
		 "septiembre" => "september" ,
		 "octubre" => "october" ,
		 "noviembre" => "november" ,
		 "diciembre" => "december" 
		}
		month_translations[month]
	end

end

require_relative 'ideal_jaen'
require_relative 'diario_jaen'
require_relative 'viva_jaen'
