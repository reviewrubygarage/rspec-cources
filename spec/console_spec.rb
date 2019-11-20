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

    context 'add book' do
      let(:expected_name) { 'Book name' }
      let(:input_sequence) { ['add', 'Book name', 'quit'] }
      let(:library_double) { instance_double('Library') }

      before do
        allow(Library).to receive(:new) { library_double }
        allow(library_double).to receive(:add_book)
      end

      it 'calls add_book with expected name' do
        console
        expect(library_double).to have_received(:add_book)
          .with(name: expected_name)
      end

      it 'prints Enter book name' do
        expect { console }.to output(/Enter book name/).to_stdout
      end

      it 'prints Book was successfully added' do
        expect { console }.to output(/Book was successfully added/).to_stdout
      end

      context 'quit after Enter book name message' do
        let(:input_sequence) { %w[add quit] }

        it 'prints Book was successfully added' do
          expect { console }.not_to output(/Book was successfully added/).to_stdout
        end

        it 'quits from console app when user types quit' do
          expect { console }.to output(/Goodbye/).to_stdout
        end
      end

      context 'name is empty' do
        let(:input_sequence) { ['add', '', 'quit'] }

        before do
          allow(library_double).to receive(:add_book)
            .and_raise(PresenceValidationError)
        end

        it 'prints Name should be present' do
          expect { console }.to output(/Name should be present/).to_stdout
        end

        it 'quits from console app when user types quit' do
          expect { console }.to output(/Goodbye/).to_stdout
        end
      end
    end
  end
end
