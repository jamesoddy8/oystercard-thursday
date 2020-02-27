require 'station'

describe Station do

  # subject {described_class.new(name: "Old Street", zone: 1)}

  let(:station) {Station.new("Liverpool Street", 1)}
  it "returns the zone" do
    expect(station.zone).to be_an(Integer)
  end
  it "returns station" do
    expect(station.name).to eq "Liverpool Street"
  end
end
