require_relative 'oystercard'

class Journey

  attr_reader :trips, :entry_station, :exit_station

  def initialize(first_station)
    @entry_station = first_station
  end

  def end_journey(exit_station)
    @exit_station = exit_station
    trip = {entry: @entry_station,
    exit: @exit_station}
    @trips << trip
    @entry_station = nil
  end

end
