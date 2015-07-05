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

      it 'not raise error' do
        expect { Wavedash.normalize("こんにちは\u{301C}") }.not_to raise_error
      end
    end

    context 'destination encoding is eucjp-ms' do
      let(:encoding) { 'eucjp-ms' }

      context 'include some invalid characters' do
        let(:str) { "こんにちは\u{301C}。コンニチハ\u{2212}" }

        it_behaves_like 'a normalized string'

        it 'convert all' do
          expect(Wavedash.normalize(str)).to eq "こんにちは\u{FF5E}。コンニチハ\u{FF0D}"
        end
      end

      context 'include WAVE DASH(U+301C)' do
        let(:str) { "こんにちは\u{301C}" }

        it_behaves_like 'a normalized string'

        it 'convert it to FULLWIDTH TILDE(U+FF5E)' do
          expect(Wavedash.normalize(str)).to eq "こんにちは\u{FF5E}"
        end
      end

      context 'include MINUS SIGN(U+2212)' do
        let(:str) { "\u{2212}" }

        it_behaves_like 'a normalized string'

        it 'convert it to FULLWIDTH HYPHEN-MINUS(U+FF0D)' do
          expect(Wavedash.normalize(str)).to eq "\u{FF0D}"
        end
      end
    end

    context 'destination encoding is euc-jp' do
      let(:encoding) { 'euc-jp' }

      context 'include FULLWIDTH TILDE(U+FF5E)' do
        let(:str) { "\u{FF5E}" }

        it_behaves_like 'a normalized string'

        it 'convert it to WAVE DASH(U+301C)' do
          expect(Wavedash.normalize(str)).to eq "\u{301C}"
        end
      end

      context 'include FULLWIDTH HYPHEN-MINUS(U+FF0D)' do
        let(:str) { "\u{FF0D}" }

        it_behaves_like 'a normalized string'

        it 'convert it to MINUS SIGN(U+2212)' do
          expect(Wavedash.normalize(str)).to eq "\u{2212}"
        end
      end
    end
  end

  describe '#invalid?' do
    before do
      Wavedash.destination_encoding = encoding
    end

    context 'destination_encoding is not set' do
      let(:encoding) { nil }

      it 'not raise error' do
        expect { Wavedash.invalid?("こんにちは\u{301C}") }.not_to raise_error
      end
    end

    context 'destination_encoding is eucjp-ms' do
      let(:encoding) { 'eucjp-ms' }

      it 'return false when not invalid characters' do
        expect(Wavedash.invalid?('こんにちは')).to be_falsey
      end

      it 'return true when include WAVE DASH(U+301C)' do
        expect(Wavedash.invalid?("\u{301C}")).to be_truthy
      end
    end

    context 'destination_encoding is euc-jp' do
      let(:encoding) { 'euc-jp' }

      it 'return false when not invalid characters' do
        expect(Wavedash.invalid?('こんにちは')).to be_falsey
      end

      it 'return true when include FULLWIDTH TILDE(U+FF5E)' do
        expect(Wavedash.invalid?("\u{FF5E}")).to be_truthy
      end
    end
  end
end
