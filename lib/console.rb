require_relative 'library'

class Console
  def initialize
    @library = Library.new
  end

  def run
    greeting
  end

  private

  def greeting
    puts 'Hello'
  end
end
