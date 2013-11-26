require 'digest/md5'

module New

	class AbstractNew

    REDIS_PREFIX = 'news'
		attr_accessor :url, :body, :relevance, :text, :heading

		def initialize(attributes = {})
			attributes = {relevance: false, text: "", heading: "", body: ""}.merge(attributes)
			@url = attributes[:url]
			@body = attributes[:body]
			@relevance = attributes[:relevance]
			@text = attributes[:text]
			@heading = attributes[:heading]
		end

		def id 
			Digest::MD5.hexdigest(@url)
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

		def normalize(string)
				Normalizer.news_process(string)
		end

		def persisted?
			!redis.get("#{REDIS_PREFIX}:#{id}:url").nil?
		end

		def dupe?
			md5 = Digest::MD5.hexdigest(@url.split('?')[0])
			redis.sismember("#{REDIS_PREFIX}:all", md5)
		end

		def save
			return false if dupe?
			redis.multi do 
				redis.sadd("#{REDIS_PREFIX}:all", id)
				redis.set("#{REDIS_PREFIX}:#{id}:url", @url)
				#redis.set("#{REDIS_PREFIX}:#{id}:body", @body)
				redis.set("#{REDIS_PREFIX}:#{id}:relevance", @relevance)
				redis.set("#{REDIS_PREFIX}:#{id}:text", @text)
				redis.set("#{REDIS_PREFIX}:#{id}:heading", @heading)
				redis.set("#{REDIS_PREFIX}:#{id}:klass", self.class.to_s)
			end
		end

		def self.find_all
			members = redis.smembers("#{REDIS_PREFIX}:all")
			members.map do |member_id|
				url = redis.get("#{REDIS_PREFIX}:#{member_id}:url")
				#body = redis.get("#{REDIS_PREFIX}:#{member_id}:body")
				relevance = redis.get("#{REDIS_PREFIX}:#{member_id}:relevance")
				text = redis.get("#{REDIS_PREFIX}:#{member_id}:text")
				heading = redis.get("#{REDIS_PREFIX}:#{member_id}:heading")
				klass = redis.get("#{REDIS_PREFIX}:#{member_id}:klass")
				class_from_string(klass).new(url: url, body: body, relevance: true, text: text, heading: heading)
			end
		end

		def self.class_from_string(str)
		  str.split('::').inject(Object) do |mod, class_name|
		    mod.const_get(class_name)
		  end
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

		def persisted?
			false
		end

		def save
			false
		end

	end

end

require_relative 'ideal_jaen'
require_relative 'diario_jaen'
require_relative 'viva_jaen'