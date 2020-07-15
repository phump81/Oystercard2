require 'oystercard'

class Journey

  attr_reader  :entry_station

  def initialize(first_station = nil)
    @entry_station = first_station
  end

  def fare
    -Oystercard::MINIMUM_BALANCE
  end





  def show
  end

end
