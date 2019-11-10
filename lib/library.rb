class Library
  EMPTY_LIBRARY_MESSAGE = 'Library is empty'.freeze

  attr_reader :books

  def initialize(books = [])
    @books = books
  end

  def add_book(name:)
    books << { name: name }
  end

  def show_books
    return EMPTY_LIBRARY_MESSAGE if books.empty?

    books.each_with_index.map do |book, index|
      "#{index + 1}. #{book[:name]}"
    end.join("\n")
  end
end
