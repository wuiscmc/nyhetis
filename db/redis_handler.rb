require 'redis'
require 'redis-namespace'
require 'psych'

def redis
    $redis ||=  Redis::Namespace.new(CONFIG['database']['namespace'], :redis => Redis.new)
end

def redis_seeds(env)
  redis.del(CrawlCommand::REDIS_PREFIX + ":crawling") 
  words = Psych.load_file("config/words_test.yml")["words"]
  words.each {|word| redis.sadd(BagOfWords::Word::REDIS_PREFIX, word)}
end