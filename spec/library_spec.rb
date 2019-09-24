require 'library'

RSpec.describe Library do
  describe '.new' do
    it 'initializes empty Library' do
      library = Library.new
      expect(library.books.size).to eq 0
    end

    specify { expect(Library.new.books).to be_a Array }
  end
end
