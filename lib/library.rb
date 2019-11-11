class Library
  EMPTY_LIBRARY_MESSAGE = 'Library is empty'.freeze

  attr_reader :books

  def initialize(books = [])
    @books = books
  end

  def add_book(name:)
    raise PresenceValidationError if name.nil? || name.empty?
    books << { name: name }
  end

  def show_books
    return EMPTY_LIBRARY_MESSAGE if books.empty?

    compose_books_message
  end

  def remove_book(id)
    raise_digit_validation_error(id) unless is_digit?(id)
    book_index = id.to_i - 1
    raise_not_found_error(id) unless book_exists?(book_index)
    books.delete_at(book_index)
  end

  private

  def compose_books_message
    books.each_with_index.map do |book, index|
      "#{index + 1}. #{book[:name]}"
    end.join("\n")
  end

  def raise_not_found_error(id)
    raise BookNotFoundError, "Book with id #{id} not found"
  end

  def raise_digit_validation_error(id)
    raise DigitValidationError, 'Please provide a correct digit value'
  end

  def book_exists?(index)
    !books[index].nil?
  end

  def is_digit?(id)
    id.to_s.match(/^[1-9]\d*$/)
  end
end

class BookNotFoundError < StandardError; end
class DigitValidationError < StandardError; end
class PresenceValidationError < StandardError; end
