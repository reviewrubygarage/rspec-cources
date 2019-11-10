require 'library'

RSpec.describe Library do
  describe '.new' do
    it 'initializes empty Library' do
      library = Library.new
      expect(library.books.size).to eq 0
    end

    specify { expect(Library.new.books).to be_a Array }
  end

  describe '#add_book' do
    it 'adds book with name to library' do
      library = Library.new
      book_name = 'First book'
      library.add_book(name: book_name)
      expect(library.books).to match([{name: book_name}])
    end

    it 'increases books count by 1' do
      library = Library.new
      book_name = 'First book'
      expect { library.add_book(name: book_name) }.to(
        change{ library.books.size }.from(0).to(1)
      )
    end
  end
end
