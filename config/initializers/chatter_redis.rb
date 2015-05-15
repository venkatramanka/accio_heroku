#This file reads redis configuration from chatter_config.yml 
#and creates a redis-connection object
require 'yaml'
require 'redis'
config = YAML.load_file('config/chatter_config.yml')
if ENV["REDISTOGO_URL"]
  uri = URI.parse(ENV["REDISTOGO_URL"])
  $redis = Redis.new(:host => uri.host, :port => uri.port)
else
  redis_config = config['redis'][Rails.env]
  $redis = Redis.new(:host => redis_config['host'], :port => redis_config['port'])
end
$online_users = Array.new