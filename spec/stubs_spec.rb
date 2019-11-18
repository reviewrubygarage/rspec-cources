require 'library'

RSpec.describe 'Stubs examples' do
  let(:message) { 'Message' }
  let(:text) { 'Text' }

  specify {
    null_object = double('null object').as_null_object
    expect(null_object).to respond_to(:any_undefined_method)
  }

  context 'double' do
    it 'with stubbed methods' do
      library = double('Library Double',
                       show_books: message,
                       undefined_method: text)
      expect(library.show_books).to eq message
      expect(library.undefined_method).to eq text
    end
  end

  context 'instance_double' do
    it 'returns message' do
      library = instance_double('Library', show_books: message)
      expect(library.show_books).to eq message
    end
  end

  context 'class_double' do
    it 'transfer_nested_constants' do
      library_class = class_double('Library')
        .as_stubbed_const(transfer_nested_constants: true)

      expect(library_class::EMPTY_LIBRARY_MESSAGE).to eq('Library is empty')
    end
  end

  context 'object_double' do
    it 'returns message' do
      library = object_double(Library.new, show_books: message)
      expect(library.show_books).to eq message
    end
  end

  context 'Allowing messages' do
    it 'stub double' do
      double = double('Test Double')
      allow(double).to receive(:method_one).and_return(message)
      expect(double.method_one).to eq message
    end

    it 'multiple method stub' do
      double = double('Test Double')
      allow(double).to receive_messages(
        method_one: message,
        method_two: text
      )
      expect(double.method_one).to eq message
      expect(double.method_two).to eq text
    end

    it 'multiple calls of stubbed method' do
      double = double('Test Double')
      allow(double).to receive(:get_a_number).and_return(1, 2, 3)
      expect(double.get_a_number).to eq 1
      expect(double.get_a_number).to eq 2
      expect(double.get_a_number).to eq 3
    end
  end

  context 'Partial doubles' do
    it 'returns message' do
      library = instance_double('Library', show_books: message)
      allow(Library).to receive(:new) { library }
      expect(Library.new.show_books).to eq message
    end
  end
end
