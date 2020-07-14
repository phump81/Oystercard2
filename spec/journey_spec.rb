require 'journey'

describe 'Journey' do
  it 'Show a journey' do
    expect(subject).to respond_to(:show)
  end
end
