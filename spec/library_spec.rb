require 'library'

RSpec.describe Library do
  subject(:library) { described_class.new(books) }
  let(:books) { [] }

  describe '.new' do
    it 'initializes empty Library' do
      expect(library.books).to be_empty
    end

    specify { expect(library.books).to be_a Array }
  end

  describe '#add_book' do
    let(:book_name) { 'First book' }

    it 'adds book with name to library' do
      library.add_book(name: book_name)
      expect(library.books).to match([{name: book_name}])
    end

    it 'increases books count by 1' do
      expect { library.add_book(name: book_name) }.to(
        change{ library.books.size }.from(0).to(1)
      )
    end
  end

  describe '#show_books' do
    context 'empty Library' do
      let(:expected_message) { 'Library is empty' }

      it 'returns empty message' do
        expect(subject.show_books).to eq expected_message
      end
    end

    context 'Library with books' do
      let(:expected_message) do
        "1. #{book_name_1}"\
        "\n"\
        "2. #{book_name_2}"
      end
      let(:book_name_1) { 'Book 1' }
      let(:book_name_2) { 'Book 2' }
      let(:books) { [{ name: book_name_1 }, { name: book_name_2 }] }

      it 'returns a list of books' do
        expect(subject.show_books).to eq expected_message
      end
    end
  end

  describe '#remove_book' do
    let(:books) { [{ name: 'Book 1' }] }

    it 'removes book from library' do
      expect { subject.remove_book(1) }.to(
        change { subject.books.size }.from(1).to(0)
      )
    end

    context 'book with such id does not exist' do
      it 'raises BookNotFound error' do
        expect { subject.remove_book(999) }.to raise_error(BookNotFoundError, /with id 999 not found/)
      end
    end

    context 'id is nil' do
      it 'raises DigitValidationError' do
        expect { subject.remove_book(nil) }.to(
          raise_error(DigitValidationError)
        )
      end
    end

    context 'id is empty string' do
      it 'raises DigitValidationError' do
        expect { subject.remove_book('') }.to(
          raise_error(DigitValidationError)
        )
      end
    end

    context 'id is not ad digit' do
      it 'raises DigitValidationError' do
        expect { subject.remove_book('not_a_digit') }.to(
          raise_error(DigitValidationError)
        )
      end
    end

    context 'id is zero' do
      it 'raises DigitValidationError' do
        expect { subject.remove_book('0') }.to(
          raise_error(DigitValidationError)
        )
      end
    end
  end
end
