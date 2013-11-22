require 'redis'
require 'redis-namespace'

def redis
    $redis ||=  Redis::Namespace.new(CONFIG['database']['namespace'], :redis => Redis.new)
end

class RedisHandler

  def initialize(id)
    @id = id
  end
  
  def ==(other)
    @id.to_s == other.id.to_s
  end
  
  attr_reader :id
  
  def self.property(name)
    klass = self.name.downcase
    self.class_eval <<-RUBY
      def #{name}
        _#{name}
      end
      
      def _#{name}
        redis.get("#{klass}:id:" + id.to_s + ":#{name}")
      end
      
      def #{name}=(val)
        redis.set("#{klass}:id:" + id.to_s + ":#{name}", val)
      end
    RUBY
  end
  # redis.set("user:id:#{user_id}:username", username)
  # redis.set("user:username:#{username}", user_id)
  # redis.set("user:id:#{user_id}:salt", salt)
  # redis.set("user:id:#{user_id}:hashed_password", hash_pw(salt, password))
  # redis.push_head("users", user_id)

end  