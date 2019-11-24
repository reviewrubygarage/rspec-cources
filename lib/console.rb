require_relative 'library'

class Console
  INITIAL_STATE = :greeting

  def initialize(initial_state = INITIAL_STATE)
    @library = Library.new
    @state = initial_state
  end

  def run
    loop do
      case @state
      when :greeting then greeting
      when :choose_option then choose_option
      when :add_book then add_book
      when :remove_book then remove_book
      when :show_books then show_books
      when :goodbye then goodbye
      when :quit then break
      end
    end
  end

  private

  def greeting
    puts 'Hello'
    set_state(:choose_option)
  end

  def choose_option
    puts "Please choose an option\n"\
    "add - add new book to library\n"\
    "remove - remove book from library\n"\
    "show - show available books in library\n"\
    'quit - to quit library'
    case read_input
    when 'add' then set_state(:add_book)
    when 'remove' then set_state(:remove_book)
    when 'show' then set_state(:show_books)
    when 'quit' then set_state(:goodbye)
    else
      puts 'Invalid option'
    end
  end

  def add_book
    puts 'Enter book name'
    input = read_input
    set_state(:goodbye) && return if input == 'quit'
    @library.add_book(name: input)
    puts 'Book was successfully added'
    set_state(:choose_option)
  rescue PresenceValidationError
    puts 'Name should be present'
  end

  def remove_book
    puts 'Enter book id'
    input = read_input
    set_state(:goodbye) && return if input == 'quit'
    @library.remove_book(input)
    puts 'Book was successfully deleted'
    set_state(:choose_option)
  rescue BookNotFoundError
    puts 'Book not found'
  rescue DigitValidationError
    puts 'Invalid id value'
  end

  def show_books
    puts @library.show_books
    set_state(:choose_option)
  end

  def set_state(state)
    @state = state
  end

  def goodbye
    puts 'Goodbye'
    set_state(:quit)
  end

  def read_input
    STDIN.gets.chomp
  end
end
