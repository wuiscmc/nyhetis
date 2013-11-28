require_relative 'bag_of_words'

class RelevanceCommand

  def initialize
    @words = BagOfWords.retrieve_words
  end

	def calculate(new)
    words_in_text?(new.heading) || words_in_text?(new.text)
  end

  private 

  def words_in_text?(text)
    !@words.select{ |word| word.in?(text) }.empty?
  end


end
