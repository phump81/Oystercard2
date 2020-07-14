require 'station'

describe 'Station' do

  let(:name){ double :station }
  let(:zone){ double 1 }

  it 'Show name and zone of a station' do
    station = Station.new(name, zone)
    expect(station.info).to eq("#{name}: Zone #{zone}")
  end
end
