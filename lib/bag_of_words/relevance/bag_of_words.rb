require 'psych'
require_relative '../../util/normalizer'

class BagOfWords

  REDIS_PREFIX = 'bagwords:words'

  def self.retrieve_words
    redis.smembers(REDIS_PREFIX).map{|w| Word.new(text: w)}
  end

  def self.empty?
    retrieve_words.empty?
  end

  def fetch_words
    redis.smembers(REDIS_PREFIX).map{|w| Word.new(text: w)}
  end

  def empty?
    fetch_words.empty?
  end

  def add_word(word)
    delete_word(word)
    redis.sadd(REDIS_PREFIX, word)
  end

  def delete_word(word)
    redis.srem(REDIS_PREFIX, word)
  end

  class Word 

    attr_accessor :text

    def initialize(params = {})
      @text = normalize(params[:text])
    end

    def in?(string)
      !(normalize(string) =~ /\b#{@text}\b/).nil?
    end

    def to_s
      @text
    end

    private 

    def normalize(string)
      Normalizer.process(string)
    end

  end
end
