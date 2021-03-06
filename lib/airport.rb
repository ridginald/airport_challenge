require_relative 'weather'

class Airport

  DEFAULT_CAPACITY = 20

  def initialize(capacity = DEFAULT_CAPACITY, weather)
    @capacity = capacity
    @weather = weather
    @planes = []
  end

  def land(plane)
    raise 'Cannot land: airport full' if full?
    raise 'Cannot land: stormy weather' if stormy?
    @planes << plane
  end

  def take_off(plane)
    raise 'Cannot take off: stormy weather' if stormy?
  end

  private

  def full?
    @planes.length >= @capacity
  end

  def stormy?
    @weather.stormy?
  end
end
