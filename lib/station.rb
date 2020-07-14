class Station

  attr_reader :name, :zone

  def initialize(name, zone)
    @name = name
    @zone = zone
  end

  def info
    return "#{@name}: Zone #{@zone}"
  end

end
