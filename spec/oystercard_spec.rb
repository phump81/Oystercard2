require_relative '../lib/oystercard'
max = 90
describe Oystercard do
  it { is_expected.to be_an Oystercard }
  it { is_expected.to respond_to :top_up }
  it { expect(subject.balance).to be_an(Integer) }
  it { expect(Oystercard::MAXIMUM_BALANCE).to be(max) }
  it { expect(subject.maximum_balance).to be(max) }
end

describe Oystercard do
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
  it 'deducts an amount from the balance' do
    subject.top_up(10)
    expect(subject.deduct(10)).to eq(subject.balance)
  end
  it 'raises an error when there is not enough money' do
    expect{ subject.deduct(1) }.to raise_error
  end
end
