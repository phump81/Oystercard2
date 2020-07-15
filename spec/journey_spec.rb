require 'journey'

describe Journey do

  let(:station){ double :station }

  it 'Show a journey' do
    expect(subject).to respond_to(:show)
  end

  it 'set the oystercard in use' do
    card = Oystercard.new(10.00)
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

  it 'Returns the minimum fare' do
    card = Oystercard.new(10.00)
    card.touch_in(station)
    expect(subject.fare).to eq(-Oystercard::MINIMUM_BALANCE)
  end
end
