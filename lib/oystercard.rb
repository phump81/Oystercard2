class Oystercard
  attr_reader :balance, :maximum_balance
  MAXIMUM_BALANCE = 90
  def initialize(balance = 0, maximum = MAXIMUM_BALANCE)
    raise('Start balance exceeds your maximum') if
        (@balance = balance) > (@maximum_balance = maximum)
  end

  def top_up(amount)
    raise("Exceeded maximum balance: #{@maximum_balance}") if
        (@balance += amount) > @maximum_balance

    @balance
  end
  def deduct(amount)
    raise("Balance too low: #{@balance}") if (@balance -= amount) < 0.00

    @balance
  end
end

