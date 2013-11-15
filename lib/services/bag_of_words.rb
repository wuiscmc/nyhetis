class BagOfWords
  def self.retrieve_words
    Word.all
  end

  class Word

    attr_accessor :text

    def self.all 
      [Word.new(text: "Universidad")]
    end

    def initialize(params = {})
      @text = params[:text]
    end

    def in?(text)
      text.include?(@text)
    end

    def to_s
      @text
    end

  end
end
