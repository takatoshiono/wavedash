require 'spec_helper'

describe Wavedash do
  it 'has a version number' do
    expect(Wavedash::VERSION).not_to be nil
  end

  describe '#normalize' do
    before do
      Wavedash.destination_encoding = encoding
    end

    context 'destination encoding is not set' do
      let(:encoding) { nil }
      let(:str) { 'こんにちは〜' }

      it 'not raise error' do
        expect { Wavedash.normalize(str) }.not_to raise_error
      end

      it 'returns the untouched argument' do
        expect(Wavedash.normalize(str)).to eq str
      end
    end
  end

  describe '#invalid?' do
    before do
      Wavedash.destination_encoding = encoding
    end

    context 'destination encoding is not set' do
      let(:encoding) { nil }
      let(:str) { 'こんにちは〜' }

      it 'not raise error' do
        expect { Wavedash.invalid?(str) }.not_to raise_error
      end

      it 'returns false' do
        expect(Wavedash.invalid?(str)).to be_falsey
      end
    end
  end
end
