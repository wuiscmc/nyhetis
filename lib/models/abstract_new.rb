require 'nokogiri'
module New

	class AbstractNew

		attr_accessor :url, :body, :relevance, :text, :header

		def initialize(attributes = {})
			@url = attributes[:url]
			@body = attributes[:body]
			@relevance = false
			@text = ""
			@header = ""
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
			raise "abstract method"
		end

	end

	class NullNew < AbstractNew

		def initialize(params = {})
		end

		def valid?
			false
		end

		def relevant?
			false
		end

	end

end

require_relative 'ideal_jaen'
require_relative 'diario_jaen'
require_relative 'viva_jaen'