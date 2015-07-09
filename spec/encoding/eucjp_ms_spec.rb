require 'spec_helper'

describe 'destination encoding is eucjp-ms' do
  let(:encoding) { 'eucjp-ms' }

  before do
    Wavedash.destination_encoding = encoding
  end

  describe '#normalize' do
    context 'includes some invalid characters' do
      let(:str) { "こんにちは〜。コンニチハ−" }
      let(:normalized_str) { "こんにちは～。コンニチハ－" }

      it_behaves_like 'a unencodable string before-after'
      it_behaves_like 'a expected normalization'
    end

    context 'includes WAVE DASH(U+301C)' do
      let(:str) { "こんにちは〜" }
      let(:normalized_str) { "こんにちは～" }

      it_behaves_like 'a unencodable string before-after'
      it_behaves_like 'a expected normalization'
    end

    context 'includes MINUS SIGN(U+2212)' do
      let(:str) { "−" }
      let(:normalized_str) { "－" }

      it_behaves_like 'a unencodable string before-after'
      it_behaves_like 'a expected normalization'
    end

    context 'includes DOUBLE VERTICAL LINE(U+2016)' do
      let(:str) { "‖" }
      let(:normalized_str) { "∥" }

      it_behaves_like 'a unencodable string before-after'
      it_behaves_like 'a expected normalization'
    end

    context 'includes EM DASH(U+2014)' do
      let(:str) { "—" }
      let(:normalized_str) { "―" }

      it_behaves_like 'a unencodable string before-after'
      it_behaves_like 'a expected normalization'
    end

    context 'includes CENT SIGN(U+00A2)' do
      let(:str) { "¢" }
      let(:normalized_str) { "￠" }

      it_behaves_like 'a unencodable string before-after'
      it_behaves_like 'a expected normalization'
    end

    context 'includes POUND SIGN(U+00A3)' do
      let(:str) { "£" }
      let(:normalized_str) { "￡" }

      it_behaves_like 'a unencodable string before-after'
      it_behaves_like 'a expected normalization'
    end

    context 'includes NOT SIGN(U+00AC)' do
      let(:str) { "¬" }
      let(:normalized_str) { "￢" }

      it_behaves_like 'a unencodable string before-after'
      it_behaves_like 'a expected normalization'
    end
  end

  describe '#invalid?' do
    it 'returns false when not invalid characters' do
      expect(Wavedash.invalid?('こんにちは')).to be_falsey
    end

    it 'returns true when include WAVE DASH(U+301C)' do
      expect(Wavedash.invalid?("こんにちは〜")).to be_truthy
    end

    it 'returns true when include DOUBLE VERTICAL LINE(U+2016)' do
      expect(Wavedash.invalid?("‖")).to be_truthy
    end

    it 'returns true when include EM DASH(U+2014)' do
      expect(Wavedash.invalid?("—")).to be_truthy
    end

    it 'returns true when include CENT SIGN(U+00A2)' do
      expect(Wavedash.invalid?("¢")).to be_truthy
    end

    it 'returns true when include POUND SIGN(U+00A3)' do
      expect(Wavedash.invalid?("£")).to be_truthy
    end

    it 'returns true when include NOT SIGN(U+00AC)' do
      expect(Wavedash.invalid?("¬")).to be_truthy
    end
  end
end
