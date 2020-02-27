require_relative "oystercard"
class Journey
attr_reader :entry_station, :exit_station, :journeys
def initialize
  @in_journey = false
  @entry_station = nil
  @exit_station = nil
  @journeys = []
end
def start_journey(station)
  penalty_fare = true if @entry_station 
  @entry_station = station
  @in_journey = true
  penalty_fare
end
def finish_journey(station)
  @exit_station = station
  @journeys << { @entry_station => @exit_station } 
  @in_journey = false
  return false if @entry_station == nil
  @entry_station = nil
  true
end

def fare

end

def journey_complete?
  # => !! forces a predicate method to return ONLY true or false (no NIL)
  # why entry_station and not @entry_station
  !!entry_station
end

end
