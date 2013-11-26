require_relative './normalizer'
require 'psych'

class BagOfWords

  def self.retrieve_words
    Word.all
  end

  class Word 

    attr_accessor :text
    REDIS_PREFIX = 'bagwords:words'

    def initialize(params = {})
      @text = normalize(params[:text])
    end
    
    def self.all 
      redis.smembers(REDIS_PREFIX).map{|w| Word.new(text: w)}
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
