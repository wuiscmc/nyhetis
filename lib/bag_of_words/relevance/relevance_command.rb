require_relative 'bag_of_words'

class RelevanceCommand

  def initialize
    @words = bag_of_words.fetch_words
  end

	def calculate(new)
    words_in_text(new.heading) + words_in_text(new.text)
  end

  private 

  def words_in_text(text)
    @words.inject(0){|sum, word| sum += word.matches_in_text(text) }
  end

  def bag_of_words
    @bag_of_words ||= BagOfWords.new
  end


end
