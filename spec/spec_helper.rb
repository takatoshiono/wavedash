$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'wavedash'

RSpec.configure do |config|
  config.filter_run_including :focus => true
  config.run_all_when_everything_filtered = true
end

RSpec.shared_examples 'a unencodable string before-after' do
  it 'raises exception when encode before normalize' do
    expect {
      str.encode(encoding)
    }.to raise_error Encoding::UndefinedConversionError
  end

  it 'not raise when encode after normalize' do
    expect {
      Wavedash.normalize(str).encode(encoding)
    }.not_to raise_error
  end
end

RSpec.shared_examples 'a expected normalization' do
  it "is converted to a encodable string" do
    expect(Wavedash.normalize(str)).to eq normalized_str
  end
end
