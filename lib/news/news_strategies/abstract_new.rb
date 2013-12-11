module New

	class AbstractNew

		attr_accessor :relevance

		attr_accessor :url, :text, :heading, :body

		def initialize(attributes = {})
			attributes = {id: nil, relevance: false, text: "", heading: "", body: ""}.merge(attributes)
			@id = attributes[:id]
			@url = attributes[:url]
			@body = attributes[:body]
			@relevance = attributes[:relevance]
			@text = attributes[:text]
			@heading = attributes[:heading]
			parse_content()
		end

		def source
			raise StandardError, 'Abstract method'
		end

		def valid?
			!@text.empty?
		end

		def relevant?
			@relevance
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
			{url: url, heading: heading, content: text, source: source}.to_json
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
