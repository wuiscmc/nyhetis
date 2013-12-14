require_relative 'relevance/bag_of_words'
require_relative 'relevance/relevance_command'

class BagOfWordsController

  def add_word(word)
    bag_of_words.add_word(word)
  end

  def delete_word(word)
    bag_of_words.delete_word(word)
  end

  def fetch_words()
    bag_of_words.fetch_words()
  end

  private

  def bag_of_words
    @bag_of_words ||= BagOfWords.new
  end

end
