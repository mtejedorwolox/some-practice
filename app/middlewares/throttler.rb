class Throttler
  def initialize(app)
    @app = app
  end

  def call(env)
    req = Rack::Request.new(env)
    api_key = req.params['api_key']
    return @app.call(env) unless api_key.present?
    day_requests(api_key)
    if (throttled?(api_key))
      [429, {'Content-Type' => 'application/json'}, []]
    else
      add_count(api_key)
      @app.call(env)
    end
  end

  private

  def store
    @store ||= ActiveSupport::Cache::MemoryStore.new
  end

  def increment(key, expires_in)
    result = store.increment(key, 1, :expires_in => expires_in)
    store.write(key, 1, :expires_in => expires_in) if result.nil?
    result || 1
  end

  def day_requests(key)
    expires_in = ((DateTime.now.end_of_day - DateTime.now) * 24 * 60 * 60).to_i
    increment(day_prefix(key), expires_in)
  end

  def throttled?(key)
    store.read(day_prefix(key)) > 100 &&
      store.read(count_prefix(key)).present?
  end

  def day_prefix(key)
    "throttler:day_requests:#{key}"
  end

  def count_prefix(key)
    "throttler:counter:#{key}"
  end

  def add_count(key)
    increment(count_prefix(key), 10)
  end
end
