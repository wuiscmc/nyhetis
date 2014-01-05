require 'redis'
require 'redis-namespace'
require 'psych'

def redis
    host = CONFIG['database']['host']
    port = CONFIG['database']['port']
    ns = CONFIG['database']['namespace']
    $redis ||=  Redis::Namespace.new(ns, :redis => Redis.new(host: host, port: port))
end
