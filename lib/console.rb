require_relative 'library'

class Console
  def initialize
    @library = Library.new
  end

  def run
    greeting
    loop do
      break unless choose_option
    end
    goodbye
  end

  private

  def choose_option
    show_options
    case read_input
    when 'show'
      puts @library.show_books
      true
    when 'quit'
      false
    end
  end

  def show_options
    puts "Please choose an option\n"\
    "add - add new book to library\n"\
    "remove - remove book from library\n"\
    "show - show available books in library\n"\
    'quit - to quit library'
  end

  def greeting
    puts 'Hello'
    @state = :choose_option
  end

  def goodbye
    puts 'Goodbye'
  end

  def read_input
    STDIN.gets.chomp
  end
end
