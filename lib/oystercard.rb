require_relative 'journey'

class Oystercard
  attr_reader :maximum_balance, :entry_station, :exit_station
  attr_accessor :balance, :trips
  MAXIMUM_BALANCE = 90.00
  MINIMUM_BALANCE = 1.00
  MAXIMUM_FARE = 5.00
  def initialize(balance = 0.00, maximum = MAXIMUM_BALANCE)
    raise('Start balance exceeds your maximum') if
      (@balance = balance) > (@maximum_balance = maximum)
    @trips = []
  end

  def top_up(amount)
    raise("Exceeded maximum balance: #{@maximum_balance}") if
        (@balance += amount) > @maximum_balance

    @balance
  end


  def touch_in(first_station)
    raise("Insufficient balance") if @balance < Oystercard::MINIMUM_BALANCE
    @balance -= Oystercard::MAXIMUM_FARE if in_journey?
    @journey = Journey.new(first_station)
    @entry_station = first_station
  end

  def touch_out(exit_station)
    deduct(Oystercard::MINIMUM_BALANCE)
    @exit_station = exit_station
    trip = {entry: @entry_station,
    exit: @exit_station}
    @entry_station = nil
    @trips << trip
  end

  def in_journey?
    @entry_station != nil ? true : false
  end

  private

  def deduct(amount)
    raise("Balance too low: #{@balance}") if (@balance -= amount) < 0.00

    @balance
  end

end
