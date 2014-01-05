require_relative 'bag_of_words'

class RelevanceCommand

  def initialize
    @words = bag_of_words.fetch_words
  end

	def calculate(new)
    heading = Normalizer.process(new.heading)
    text = Normalizer.process(new.text)
    absolute_frequency = (2*words_in_text(heading)) + words_in_text(text)
    date_published = new.date_published.nil? ? beginning_of_year() : new.date_published
    adjust_factor = (Date.today - date_published).to_i + 1
    (absolute_frequency.to_f/adjust_factor.to_f).to_d(10).to_f
  end

  private 

  def words_in_text(text)
    @words.inject(0){|sum, word| sum += word.matches_in_text(text) }
  end

  def bag_of_words
    @bag_of_words ||= BagOfWords.new
  end

  def beginning_of_year
    Date.new(Date.today.year - 1, 1, 1)
  end

end
