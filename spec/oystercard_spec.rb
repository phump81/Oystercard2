require_relative '../lib/oystercard'
max = 90.00
describe Oystercard do
  it { is_expected.to be_an Oystercard }
  it { is_expected.to respond_to :top_up }
  it { expect(subject.balance).to be_an(Float) }
  it { expect(Oystercard::MAXIMUM_BALANCE).to be(max) }
  it { expect(subject.maximum_balance).to be(max) }
  it { expect(subject.trips).to be_empty }
end

describe Oystercard do
  let(:station){ double :station }
  let(:exit_station){ double :exit_station }
  let(:trips){ {entry: station, exit: exit_station} }
  it 'adds an amount to the balance' do
    expect(subject.top_up(25)).to eq(subject.balance)
  end
  it 'raises an error upon exceeding maximum via initialisation' do
    expect{ Oystercard.new(100, 50) }.to raise_error
  end
  it 'raises an error upon exceeding maximum via top-up' do
    card = Oystercard.new
    expect{ card.top_up(100) }.to raise_error("Exceeded maximum balance: #{card.maximum_balance}")
  end
  it 'deducts ten pounds from the balance' do
    subject.top_up(10)
    expect{ subject.touch_out(station) }.to change{subject.balance}.by(-1.00)
  end
  it 'raises an error when there is not enough money' do
    expect{ subject.touch_out(station) }.to raise_error
  end
  it 'set the oystercard in use' do
    card = Oystercard.new(1.00)
    card.touch_in(station)
    expect(card.in_journey?).to eq(true)
  end
  it 'set the oystercard not in use' do
    card = Oystercard.new(5.00)
    card.touch_out(station)
    expect(card.in_journey?).to eq(false)
  end
  it 'tells us if in use' do
    card = Oystercard.new(1.99)
    card.touch_in(station)
    expect(card.in_journey?).to eq(true)
  end
  it 'does not allow a balance under one pound' do
    card = Oystercard.new(0.99)
    expect{ card.touch_in(station) }.to raise_error 'Insufficient balance'
  end
  it 'remembers where I touched it' do
    subject.top_up(50.00)
    subject.touch_in(station)
    expect(subject.entry_station).to eq(station)
  end
  it "forgets entry station when touched out" do
    subject.top_up(50.00)
    subject.touch_in(station)
    subject.touch_out(exit_station)
    expect(subject.entry_station).to eq(nil)
  end
  it "remembers where I touched out" do
    subject.top_up(50.00)
    subject.touch_in(station)
    subject.touch_out(exit_station)
    expect(subject.exit_station).to eq(exit_station)
  end
  it "remembers past trips" do
    subject.top_up(50.00)
    subject.touch_in(station)
    subject.touch_out(exit_station)
    expect(subject.trips).to include trips
  end
end