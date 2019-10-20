class Library
  attr_reader :books

  def initialize(books = [])
    @books = books
  end

  def add_book(name:)
    books << { name: name }
  end
end
