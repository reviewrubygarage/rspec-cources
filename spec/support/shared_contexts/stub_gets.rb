RSpec.shared_context 'stub gets' do
  before do |example|
    allow(STDIN).to receive(:gets).and_return(*input_sequence)
  end
end
