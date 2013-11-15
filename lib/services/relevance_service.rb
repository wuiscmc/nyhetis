require_relative 'bag_of_words'
require_relative 'relevance_calculator'

class RelevanceService 

	def analyze_relevance(new)
    words = BagOfWords.retrieve_words
    relevance_calculator = RelevanceCalculator.new(words: words, text: new.text)
    relevance_calculator.calculate_relevance()
	end

end
