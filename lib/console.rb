require_relative 'library'

class Console
  def initialize
    @library = Library.new
  end

  def run
    greeting
    show_options
  end

  private

  def show_options
    puts "Please choose an option\n"\
    "add - add new book to library\n"\
    "remove - remove book from library\n"\
    "show - show available books in library\n"\
    'exit - to exit library'
  end

  def greeting
    puts 'Hello'
  end
end
