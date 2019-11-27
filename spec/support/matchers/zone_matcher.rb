RSpec::Matchers.define :be_n_elements do |n|
  match do |array|
    binding.pry
    array.size == n
  end
end
