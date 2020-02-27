require "oystercard"

describe OysterCard do
  let(:entry_station){ double(:entry_station)}
    let(:exit_station){ double(:exit_station)}

  it "initializes with default balance of 0" do
    expect(subject.balance).to eq 0
  end

  it "initializes with empty list of journeys" do
    expect(subject.journey.journeys).to be_empty
  end

  describe "#top_up" do

    it { is_expected.to respond_to(:top_up).with(1).argument }
    # it "checks if #top_up value has been given" do
    #   expect(subject).to respond_to(:top_up).with(1).argument
    # end

    it "adds #top_up value to balance" do
      #card = OysterCard.new
      expect { subject.top_up 10 }.to change{ subject.balance }.by 10

      # subject.top_up(10)
      # expect(subject.balance).to eq 10
    end

    it "raises an error if the maximum balance is exceeded" do
      maximum_balance = OysterCard::MAXIMUM_BALANCE
      subject.top_up(maximum_balance)
      expect { subject.top_up 1 }.to raise_error("Maximum balance of #{OysterCard::MAXIMUM_BALANCE} exceeded")
    end
  end


  # describe "#deduct" do

  # after moving this method into touch_out method
  # we test its functionality within touch_out method so dont need to test it
  # independently
  #
  #   it "#deducts value from balance" do
  #     # card = OysterCard.new
  #     expect { subject.deduct 5 }.to change{ subject.balance }.by -5
  #   end
  # end

  # describe "#in_journey?" do
  #
  #   it "initially set the card's status to not in journey" do
  #     # card = OysterCard.new
  #     expect(subject).not_to be_in_journey
  #   end
  # end

  describe "#touch_in" do

    let(:station){ double(:station)}

    it { is_expected.to respond_to(:touch_in).with(1).argument }

    it "can touch in" do
      subject.top_up(10)
      subject.touch_in(station)

    end
    it "will tell me I am in journey if I touch in" do
      subject.top_up(10)
      subject.touch_in(station)
      expect(subject.in_journey?).to eq true
    end

    it "will tell me I am not in journey if I don't touch in" do
      expect(subject.in_journey?).to eq false
    end

    it "remembers touch_in station " do
      subject.top_up(10)
      subject.touch_in(station)
      expect(subject.journey.entry_station).to eq(station)

    end

    it "raises an error if card balance is less than minimum balance" do
      expect { (subject.touch_in) }.not_to raise_error("Not enough balance") if subject.balance > OysterCard::MINIMUM_FARE
    end
  end

  describe "#touch_out" do

    before(:each) do
      subject.top_up(10)
      subject.touch_in(entry_station)
    end

    let(:entry_station){ double(:entry_station)}
    let(:exit_station){ double(:exit_station)}

    it "can touch out" do
      expect { subject.touch_out(exit_station) }.to change { subject.balance }.by (-OysterCard::MINIMUM_FARE)
    end

    it "stores exit station" do
      subject.touch_out(exit_station)
      expect(subject.journey.exit_station).to eq exit_station
    end

    it "creates a journey from entry_station to exit_station and stores it as hash" do
      subject.touch_out(exit_station)
      expect(subject.journey.journeys).to include { {entry_station => exit_station} }# , exit_station => exit_station}]
    end
    
  end
  it "will charge me penalty fare if I don't touch in" do
    expect{subject.touch_out(exit_station)}.to change { subject.balance }.by (-OysterCard::PENALTY_FARE)
  end
  it 'will charge me penalty fare if I dont touch out, and try and start another journey' do
    subject.top_up(40)
    subject.touch_in(entry_station)
    expect{subject.touch_in(entry_station)}.to change { subject.balance }.by (-OysterCard::PENALTY_FARE)
  end

end
