require 'console'

RSpec.describe Console do
  subject(:console) { described_class.new.run }

  describe 'run' do
    context 'greeting message' do
      it 'prints Hello' do
        expect{ console }.to output(/Hello/).to_stdout
      end
    end
  end
end
