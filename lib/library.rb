class Library
  attr_reader :books

  def initialize(books = [])
    @books = books
  end
end
