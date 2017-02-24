require_relative '../../services/book_manager.rb'

describe 'BookManager' do

  it 'should not get a book without any parameters given' do
    book = double(Book, find_by: true)
    result = BookManager.get(nil, nil, nil)
    expect(result).to eq("Book was not found")
  end

end