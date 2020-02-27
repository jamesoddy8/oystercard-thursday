class OysterCard

  attr_reader :balance, :journey

  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1
  MINIMUM_FARE = 1.5
  PENALTY_FARE = 6

  def initialize
    @balance = 0
    @journey = Journey.new
  end

  def top_up(value)
    raise "Maximum balance of #{MAXIMUM_BALANCE} exceeded" if balance + value > MAXIMUM_BALANCE
    @balance += value
  end


  def touch_in(station)
    raise "Not enough balance" if @balance < MINIMUM_FARE
    journey.start_journey(station)
  end

  def touch_out(station)
    journey.finish_journey(station)
    deduct(MINIMUM_FARE)
  end

  def in_journey?
    # => !! forces a predicate method to return ONLY true or false (no NIL)
    # why entry_station and not @entry_station
    !!journey.entry_station
  end

  private
  def deduct(amount)
    @balance -= amount
  end

end
