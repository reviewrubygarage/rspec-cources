module ConsoleHelper
  def check_goodbye
    expect { console }.to output(/Goodbye/).to_stdout
  end
end
