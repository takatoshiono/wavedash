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

    context 'destination encoding is eucjp-ms' do
      let(:encoding) { 'eucjp-ms' }

      context 'includes some invalid characters' do
        let(:str) { "こんにちは\u{301C}。コンニチハ\u{2212}" }

        it_behaves_like 'a unencodable string before-after'

        it 'converts all' do
          expect(Wavedash.normalize(str)).to eq "こんにちは\u{FF5E}。コンニチハ\u{FF0D}"
        end
      end

      context 'includes WAVE DASH(U+301C)' do
        let(:str) { "こんにちは\u{301C}" }

        it_behaves_like 'a unencodable string before-after'

        it 'converts it to FULLWIDTH TILDE(U+FF5E)' do
          expect(Wavedash.normalize(str)).to eq "こんにちは\u{FF5E}"
        end
      end

      context 'include MINUS SIGN(U+2212)' do
        let(:str) { "\u{2212}" }

        it_behaves_like 'a unencodable string before-after'

        it 'converts it to FULLWIDTH HYPHEN-MINUS(U+FF0D)' do
          expect(Wavedash.normalize(str)).to eq "\u{FF0D}"
        end
      end

      context 'include DOUBLE VERTICAL LINE(U+2016)' do
        let(:str) { "\u{2016}" }

        it_behaves_like 'a unencodable string before-after'

        it 'converts it to PARALLEL TO(U+2225)' do
          expect(Wavedash.normalize(str)).to eq "\u{2225}"
        end
      end
    end

    context 'destination encoding is euc-jp' do
      let(:encoding) { 'euc-jp' }

      context 'include FULLWIDTH TILDE(U+FF5E)' do
        let(:str) { "\u{FF5E}" }

        it_behaves_like 'a unencodable string before-after'

        it 'converts it to WAVE DASH(U+301C)' do
          expect(Wavedash.normalize(str)).to eq "\u{301C}"
        end
      end

      context 'include FULLWIDTH HYPHEN-MINUS(U+FF0D)' do
        let(:str) { "\u{FF0D}" }

        it_behaves_like 'a unencodable string before-after'

        it 'converts it to MINUS SIGN(U+2212)' do
          expect(Wavedash.normalize(str)).to eq "\u{2212}"
        end
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

    context 'destination encoding is eucjp-ms' do
      let(:encoding) { 'eucjp-ms' }

      it 'returns false when not invalid characters' do
        expect(Wavedash.invalid?('こんにちは')).to be_falsey
      end

      it 'returns true when include WAVE DASH(U+301C)' do
        expect(Wavedash.invalid?("\u{301C}")).to be_truthy
      end

      it 'returns true when include DOUBLE VERTICAL LINE(U+2016)' do
        expect(Wavedash.invalid?("\u{2016}")).to be_truthy
      end
    end

    context 'destination encoding is euc-jp' do
      let(:encoding) { 'euc-jp' }

      it 'returns false when not invalid characters' do
        expect(Wavedash.invalid?('こんにちは')).to be_falsey
      end

      it 'returns true when include FULLWIDTH TILDE(U+FF5E)' do
        expect(Wavedash.invalid?("\u{FF5E}")).to be_truthy
      end

      it 'returns true when include PARALLEL TO(U+2225)' do
        expect(Wavedash.invalid?("\u{2225}")).to be_truthy
      end
    end
  end
end
