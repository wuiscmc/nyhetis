class RelevanceCalculator
  
  def initialize(params)
    @text = params[:text]
    @words = params[:words]
  end

  def calculate_relevance
    !@words.select{|word| word.in?(@text) }.empty?
  end

end