require 'library'

RSpec.describe Library do
  before(:each) do
    @library = Library.new
  end

  describe '.new' do
    it 'initializes empty Library' do
      expect(@library.books.size).to eq 0
    end

    specify { expect(@library.books).to be_a Array }
  end

  describe '#add_book' do
    before(:all) do
      @book_name = 'First book'
    end

    it 'adds book with name to library' do
      @library.add_book(name: @book_name)
      expect(@library.books).to match([{name: @book_name}])
    end

    it 'increases books count by 1' do
      expect { @library.add_book(name: @book_name) }.to(
        change{ @library.books.size }.from(0).to(1)
      )
    end
  end
end
