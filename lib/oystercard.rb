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
    user_didnt_tap_out = journey.start_journey(station)
    if user_didnt_tap_out == true
      deduct(PENALTY_FARE)
    end
  end

  def touch_out(station)
    correct_fare = journey.finish_journey(station)
    if correct_fare == true
      deduct(MINIMUM_FARE) 
    else
      deduct(PENALTY_FARE)
    end
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
