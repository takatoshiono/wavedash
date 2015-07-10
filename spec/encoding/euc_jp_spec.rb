require 'spec_helper'

describe 'destination encoding is euc-jp' do
  let(:encoding) { 'euc-jp' }

  before do
    Wavedash.destination_encoding = encoding
  end

  describe '#normalize' do
    context 'includes FULLWIDTH TILDE(U+FF5E)' do
      let(:str) { "こんにちは～" }
      let(:normalized_str) { "こんにちは〜" }

      it_behaves_like 'a unencodable string before-after'
      it_behaves_like 'a expected normalization'
    end

    context 'includes FULLWIDTH HYPHEN-MINUS(U+FF0D)' do
      let(:str) { "－" }
      let(:normalized_str) { "−" }

      it_behaves_like 'a unencodable string before-after'
      it_behaves_like 'a expected normalization'
    end

    context 'includes PARALLEL TO(U+2225)' do
      let(:str) { "∥" }
      let(:normalized_str) { "‖" }

      it_behaves_like 'a unencodable string before-after'
      it_behaves_like 'a expected normalization'
    end

    context 'includes FULLWIDTH CENT SIGN(U+FFE0)' do
      let(:str) { "￠" }
      let(:normalized_str) { "¢" }

      it_behaves_like 'a unencodable string before-after'
      it_behaves_like 'a expected normalization'
    end

    context 'includes FULLWIDTH POUND SIGN(U+FFE1)' do
      let(:str) { "￡" }
      let(:normalized_str) { "£" }

      it_behaves_like 'a unencodable string before-after'
      it_behaves_like 'a expected normalization'
    end

    context 'includes FULLWIDTH NOT SIGN(U+FFE2)' do
      let(:str) { "￢" }
      let(:normalized_str) { "¬" }

      it_behaves_like 'a unencodable string before-after'
      it_behaves_like 'a expected normalization'
    end
  end

  describe '#invalid?' do
    it 'returns false when not invalid characters' do
      expect(Wavedash.invalid?('こんにちは')).to be_falsey
    end

    it 'returns true when include FULLWIDTH TILDE(U+FF5E)' do
      expect(Wavedash.invalid?("こんにちは～")).to be_truthy
    end

    it 'returns true when include FULLWIDTH HYPHEN-MINUS(U+FF0D)' do
      expect(Wavedash.invalid?("－")).to be_truthy
    end

    it 'returns true when include PARALLEL TO(U+2225)' do
      expect(Wavedash.invalid?("∥")).to be_truthy
    end

    it 'returns true when include FULLWIDTH CENT SIGN(U+FFE0)' do
      expect(Wavedash.invalid?("￠")).to be_truthy
    end

    it 'returns true when include FULLWIDTH POUND SIGN(0+FFE1)' do
      expect(Wavedash.invalid?("￡")).to be_truthy
    end

    it 'returns true when include FULLWIDTH NOT SIGN(0+FFE2)' do
      expect(Wavedash.invalid?("￢")).to be_truthy
    end
  end
end
