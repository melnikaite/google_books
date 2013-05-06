module RedisCache
  class << self
    def set_or_load(key)
      if result = $redis.get(key)
        result = Marshal.load(result)
      else
        result = yield
        $redis.setex(key, Yetting.cache_ttl, Marshal.dump(result))
      end
      result
    end
  end
end
