class OysterCard

  attr_reader :balance, :journey

  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1

  def initialize
    @balance = 0
    @journey = Journey.new
  end

  def top_up(value)
    raise "Maximum balance of #{MAXIMUM_BALANCE} exceeded" if balance + value > MAXIMUM_BALANCE
    @balance += value
  end

  def touch_in(station)
    raise "Not enough balance" if @balance < Journey::MINIMUM_FARE
    journey.start_journey(station)
    deduct(@journey.fare)
  end

  def touch_out(station)
    journey.finish_journey(station)
    deduct(@journey.fare)
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
