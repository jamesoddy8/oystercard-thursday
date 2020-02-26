class OysterCard

  attr_reader :balance
  MAXIMUM_BALANCE = 90

  def initialize
    @balance = 0
  end

    def top_up(value)
      fail "Maximum balance of #{MAXIMUM_BALANCE} exceeded" if @balance + value > MAXIMUM_BALANCE
      @balance += value
    end

  def deduct(amount)
    @balance -= amount
  end

  def touch_in
    true
  end




end
