class OysterCard

  attr_reader :balance, :entry_station

  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1
  MINIMUM_FARE = 1.5

  def initialize
    @balance = 0
    @in_journey = false
    @entry_station = nil
    @exit_station = nil
  end

  def top_up(value)
    raise "Maximum balance of #{MAXIMUM_BALANCE} exceeded" if @balance + value > MAXIMUM_BALANCE
    @balance += value
  end



  def touch_in(station)
    raise "Not enough balance" if @balance < MINIMUM_FARE
    @entry_station = station
    @in_journey = true
  end

  def touch_out
    deduct(MINIMUM_FARE)
    @in_journey = false
    return @balance
  end

  def in_journey?
    # => !! forces a predicate method to return ONLY true or false (no NIL)
    !!@in_journey
  end

  private
  def deduct(amount)
    @balance -= amount
  end

end
