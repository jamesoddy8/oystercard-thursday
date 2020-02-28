require_relative "oystercard"
class Journey

  MINIMUM_FARE = 1.5
  PENALTY_FARE = 6

  attr_reader :entry_station, :exit_station, :journeys, :fare

  def initialize
    @entry_station = nil
    @exit_station = nil
    @journeys = []
    @fare = MINIMUM_FARE
  end

  def start_journey(station)
    @fare = PENALTY_FARE if @journeys.length == 0 && @entry_station
    @fare = PENALTY_FARE if @exit_station == nil && @journeys.length > 0
    @entry_station = station
    @exit_station = nil
  end

  def finish_journey(station)
    @fare = PENALTY_FARE if @entry_station == nil
    @exit_station = station
    @journeys << { @entry_station => @exit_station }
    @entry_station = nil
  end

  def journey_complete?
    # => !! forces a predicate method to return ONLY true or false (no NIL)
    # why entry_station and not @entry_station
    !!entry_station
  end

end 
