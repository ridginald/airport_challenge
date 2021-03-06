require 'airport'

describe Airport do
  subject(:airport) { described_class.new(20, weather) }
  let(:plane) { double :plane }
  let(:weather) { double :weather }

  describe '#land' do
    context 'when it is not stormy' do
      before do
        allow(weather).to receive(:stormy?).and_return false
      end
      it 'instructs a plane to land' do
        expect(airport).to respond_to(:land).with(1).argument
      end

      context 'when airport is full' do
        it 'raises an error' do
          described_class::DEFAULT_CAPACITY.times do
            airport.land(plane)
          end
          expect { airport.land(plane) }.to raise_error 'Cannot land: airport full'
        end
        it "has a default capacity" do
          allow(weather).to receive(:stormy?).and_return false
          described_class::DEFAULT_CAPACITY.times { airport.land(plane) }
          expect { airport.land(plane) }.to raise_error 'Cannot land: airport full'
        end
      end
    end

    context 'when it is stormy' do
      it 'raises an error' do
        allow(weather).to receive(:stormy?).and_return true
        expect { airport.land(plane) }.to raise_error 'Cannot land: stormy weather'
      end
    end
  end

  describe '#take_off' do
    context 'when it is not stormy' do
      before do
        allow(weather).to receive(:stormy?).and_return false
      end
      it 'instructs a plane to take off' do
        expect(airport).to respond_to(:take_off).with(1).argument
      end
      context 'when it is stormy' do
        it 'raises an error' do
          allow(weather).to receive(:stormy?).and_return true
          expect { airport.take_off(plane) }.to raise_error 'Cannot take off: stormy weather'
        end
      end
    end
  end
end
