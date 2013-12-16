require 'digest/md5'
require 'pry'
require 'date'

class NewsRepository

  REDIS_PREFIX = 'news'

  def save_new(new_fetched)
    id = Digest::MD5.hexdigest(new_fetched.url)
    unless fetch_new(new_fetched.url)
      redis.multi do # Transactions in Redis!
        redis.sadd("#{REDIS_PREFIX}:all", id)
        redis.set("#{REDIS_PREFIX}:#{id}:url", new_fetched.url)
        redis.set("#{REDIS_PREFIX}:#{id}:text", new_fetched.text)
        redis.set("#{REDIS_PREFIX}:#{id}:heading", new_fetched.heading)
        redis.set("#{REDIS_PREFIX}:#{id}:date", new_fetched.date)
        redis.set("#{REDIS_PREFIX}:#{id}:klass", new_fetched.class.to_s)
      end
    end
    new_fetched.class.new(id: id, url: new_fetched.url, relevance: true, text: new_fetched.text, heading: new_fetched.heading)
  end

  def fetch_news(params = {})
    new_ids = redis.smembers("#{REDIS_PREFIX}:all")
    fetched_news = new_ids.map { |new_id| __fetch_new(new_id) }
    apply_filters(fetched_news,params)
  end

  def fetch_new(url)
    id = Digest::MD5.hexdigest(url.split('?')[0])
    redis.sismember("#{REDIS_PREFIX}:all", id)
  end

  private

  def __fetch_new(member_id)
    url = redis.get("#{REDIS_PREFIX}:#{member_id}:url")
    text = redis.get("#{REDIS_PREFIX}:#{member_id}:text")
    heading = redis.get("#{REDIS_PREFIX}:#{member_id}:heading")
    date = redis.get("#{REDIS_PREFIX}:#{member_id}:date")
    klass = redis.get("#{REDIS_PREFIX}:#{member_id}:klass")
    class_from_string(klass).new(url: url, relevance: true, text: text, heading: heading, date: date)
  end

  def apply_filters(fetched_news, params = {})
    return fetched_news if params.empty?
    fetched_news.select do |new|
      time = Date.parse(new.date)
      from = Date.parse(params['fromts'])
      to = Date.parse(params['tots'])
      time <= to && time >= from
    end
  end

  # support for Ruby 1.9.x 
  # for Ruby 2.x.x we would just call Kernel.const_get(A::B)
  def class_from_string(str)
    str.split('::').inject(Object) do |mod, class_name|
      mod.const_get(class_name)
    end
  end


end