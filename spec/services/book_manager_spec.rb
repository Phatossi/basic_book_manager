require_relative '../../services/book_manager'
require_relative '../../models/author'
describe 'BookManager' do

  it 'should not get a book without any parameters given' do
    allow(Book).to receive(:find_by)
    result = BookManager.get(nil, nil, nil)
    expect(result).to eq("Book was not found.")
  end

  it 'should get a book by title' do
    title = 'Ego is the enemy'
    book = double(Book, find_by: true)
    allow(Book).to receive(:find_by).and_return(book)
    result = BookManager.get(title, nil, nil)
    expect(result).to eq(book)
  end

  it 'should get a book by isbn' do
    book = double(Book)
    allow(Book).to receive(:find_by).and_return(book)
    output = BookManager.get(nil, 'isbn', nil)
    expect(output).to eq(book)
  end

  it 'should get a book by author' do
    author = double(Author)
    book = double(Book, find_by: true)
    allow(Author).to receive(:find_by).and_return(author)
    allow(Book).to receive(:find_by).and_return(book)
    result = BookManager.get(nil, nil, author)
    expect(result).to eq(book)
  end


end