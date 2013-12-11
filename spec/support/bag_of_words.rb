require 'psych'

shared_context "bag_of_words" do 

  def initialize_bag_of_words
    empty_bag_of_words()
    words_file = File.expand_path('../../config/words_test.yml', File.dirname(__FILE__))
    words = Psych.load_file(words_file)["words"]
    words.each {|word| redis.sadd(BagOfWords::REDIS_PREFIX, word)}
  end

  def empty_bag_of_words
    redis.del(BagOfWords::REDIS_PREFIX)
  end

end