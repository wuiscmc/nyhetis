require 'digest/md5'
require 'date'
require 'pry'
class NewsRepository

  REDIS_PREFIX = 'news'

  ATTRIBUTES = %w(url text heading date relevance image)

  def save_new(new_fetched)
    id = Digest::MD5.hexdigest(new_fetched.url)
    exists = fetch_new(new_fetched.url)
    redis.multi do
      if exists
        redis.srem("#{REDIS_PREFIX}:all", id)
        redis.zrem("#{REDIS_PREFIX}:sorted", id)
      end
      redis.sadd("#{REDIS_PREFIX}:all", id)
      redis.zadd("#{REDIS_PREFIX}:sorted", new_fetched.relevance, id)
      redis.set("#{REDIS_PREFIX}:#{id}:klass", new_fetched.class.to_s)
      new_fetched.attributes.each do |key, value|
        redis.set("#{REDIS_PREFIX}:#{id}:#{key.to_s}", value)
      end
    end

    return new_fetched.class.new(new_fetched.attributes.merge(id: id))
  end

  def fetch_news(params = {})
    new_ids = redis.zrange("#{REDIS_PREFIX}:sorted", 0 ,-1)
    fetched_news = new_ids.map { |new_id| __fetch_new(new_id) }
    apply_filters(fetched_news,params)
  end

  def fetch_new(url)
    id = Digest::MD5.hexdigest(url.split('?')[0])
    redis.sismember("#{REDIS_PREFIX}:all", id)
  end

  private

  def __fetch_new(member_id)
    klass = redis.get("#{REDIS_PREFIX}:#{member_id}:klass")
    
    attributes = ATTRIBUTES.inject({}) do |hash, attribute|
      value = redis.get("#{REDIS_PREFIX}:#{member_id}:#{attribute}")
      hash.merge({:"#{attribute}" => value})
    end

    class_from_string(klass).new(attributes) 
  end

  def apply_filters(fetched_news, params = {})
    return fetched_news if params.empty?
    fetched_news.select do |new|
      begin
        time = Date.parse(new.date)
        from = Date.parse(params['fromts'])
        to = Date.parse(params['tots'])
        time <= to && time >= from
      rescue ArgumentError => e
        puts "invalid date"
      end
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