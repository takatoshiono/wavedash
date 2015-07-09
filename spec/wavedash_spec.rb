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

    context 'destination encoding is euc-jp' do
      let(:encoding) { 'euc-jp' }

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

    context 'destination encoding is cp932' do
      let(:encoding) { 'cp932' }

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

    context 'destination encoding is shift_jis' do
      let(:encoding) { 'shift_jis' }

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

    context 'destination encoding is euc-jp' do
      let(:encoding) { 'euc-jp' }

      it 'returns false when not invalid characters' do
        expect(Wavedash.invalid?('こんにちは')).to be_falsey
      end

      it 'returns true when include FULLWIDTH TILDE(U+FF5E)' do
        expect(Wavedash.invalid?("こんにちは～")).to be_truthy
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

    context 'destination encoding is cp932' do
      let(:encoding) { 'cp932' }

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

    context 'destination encoding is shift_jis' do
      let(:encoding) { 'shift_jis' }

      it 'returns false when not invalid characters' do
        expect(Wavedash.invalid?('こんにちは')).to be_falsey
      end

      it 'returns true when include FULLWIDTH TILDE(U+FF5E)' do
        expect(Wavedash.invalid?("こんにちは～")).to be_truthy
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
end
