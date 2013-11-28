require 'digest/md5'

class NewsRepository

  REDIS_PREFIX = 'news'

  def save_new(new)
    id = Digest::MD5.hexdigest(new.url)
    unless fetch_new(new.url)
      redis.multi do 
        redis.sadd("#{REDIS_PREFIX}:all", id)
        redis.set("#{REDIS_PREFIX}:#{id}:url", new.url)
        redis.set("#{REDIS_PREFIX}:#{id}:text", new.text)
        redis.set("#{REDIS_PREFIX}:#{id}:heading", new.heading)
        redis.set("#{REDIS_PREFIX}:#{id}:klass", new.class.to_s)
      end
    end
    class_from_string(klass).new(id: id, url: url, relevance: true, text: text, heading: heading)
  end

  def fetch_news()
    members = redis.smembers("#{REDIS_PREFIX}:all")
    members.map do |member_id|
      url = redis.get("#{REDIS_PREFIX}:#{member_id}:url")
      text = redis.get("#{REDIS_PREFIX}:#{member_id}:text")
      heading = redis.get("#{REDIS_PREFIX}:#{member_id}:heading")
      klass = redis.get("#{REDIS_PREFIX}:#{member_id}:klass")
      class_from_string(klass).new(url: url, relevance: true, text: text, heading: heading)
    end
  end

  def fetch_new(url)
    id = Digest::MD5.hexdigest(url.split('?')[0])
    redis.sismember("#{REDIS_PREFIX}:all", id)
  end

  private

  def class_from_string(str)
    str.split('::').inject(Object) do |mod, class_name|
      mod.const_get(class_name)
    end
  end


end