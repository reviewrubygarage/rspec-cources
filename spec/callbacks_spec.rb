RSpec.describe 'before and after callbacks' do
  before(:all) do
    puts 'global before all'
  end

  before(:each) do
    puts 'global before each'
  end

  after(:each) do
    puts 'global after each'
  end

  after(:all) do
    puts 'global after all'
  end

  it 'gets run in order' do
    puts 'global test 1'
  end

  it 'gets run in order' do
    puts 'global test 2'
  end

  describe 'in group' do
    before(:all) do
      puts 'group before all'
    end

    before(:each) do
      puts 'group before each'
    end

    after(:each) do
      puts 'group after each'
    end

    after(:all) do
      puts 'group after all'
    end

    it 'gets run in order' do
      puts 'group test 1'
    end

    it 'gets run in order' do
      puts 'group test 2'
    end
  end
end
