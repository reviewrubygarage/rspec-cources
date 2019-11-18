require 'console'

RSpec.describe Console do
  subject(:console) { described_class.new.run }

  describe 'run' do
    let(:input_sequence) { %w[quit] }
    before do
      allow(STDIN).to receive(:gets).and_return(*input_sequence)
    end

    context 'greeting message' do
      it 'prints Hello' do
        expect{ console }.to output(/Hello/).to_stdout
      end
    end

    context 'shows available actions' do
      let(:options_message) do
        "Please choose an option\n"\
        "add - add new book to library\n"\
        "remove - remove book from library\n"\
        "show - show available books in library\n"\
        'quit - to quit library'
      end

      it 'prints options message' do
        expect { console }.to output(/#{options_message}/).to_stdout
      end

      it 'quits from console app when user types quit' do
        expect { console }.to output(/Goodbye/).to_stdout
      end
    end

    context 'show books' do
      let(:expected_books) { 'Expected books' }
      let(:input_sequence) { %w[show quit] }
      let(:library_double) { instance_double('Library', show_books: expected_books) }

      before do
        allow(Library).to receive(:new) { library_double }
      end

      it 'prints available books on typing show' do
        expect { console }.to output(/#{expected_books}/).to_stdout
      end
    end
  end
end
