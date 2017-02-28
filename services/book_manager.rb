require_relative 'manager'
require_relative 'author_manager'
require_relative '../models/book'

class BookManager < Manager


  def self.get(title, isbn, author)
    open_database_connection
      if title == 'all'
        books = Book.all
        if !books
          'No book found.'
        else
          books
        end
      else if !is_string_blank?(title)
        book = Book.find_by(title: title)
        if !book.is_a? (Book)
          'Book was not found'
        else
          book
        end
      elsif !is_string_blank?(isbn)
        book = Book.find_by(isbn: isbn)
        if !book.is_a? (Book)
          'Book was not found'
        else
          book
        end
      elsif author
        author = AuthorManager.get(name)
        if !author.is_a? (Author)
         book = Book.find_by(author: author)
          if !book
            'Book was not found'
          end
         book
        end
      else
        'Book was not found.'
      end
      end
    end


  def self.add(title, isbn, author)
    if is_string_blank?(title)
      'Book title cannot be empty.'
    elsif is_string_blank?(isbn)
      'Book ISBN cannot be empty.'
    elsif !author.is_a? (Author)
      'Book author cannot be empty.'
    else
      open_database_connection
        Book.create({
          title: title,
          isbn: isbn,
          author: author
          })
      'Book was added successfully.'
      end
  end

  def self.edit(old_title, title, isbn)
    if Manager.is_string_blank? (old_title)
      'Please provide the title of the book.'
    else
      open_database_connection
      book = BookManager.get(old_title, '', '')
      puts book
      if !book
          'Book was not found.'
      else
        if !Manager.is_string_blank?(title)
          book.update(title: title)
        end
        if !Manager.is_string_blank?(isbn)
          book.update(isbn: isbn)
        end
        book.save
        'The book was updated successfully.'
      end
    end
  end


  def self.delete(title)
    open_database_connection
    book = BookManager.get(title, nil, nil)
    if !book.is_a?(Book)
      'Book was not found.'
    else
      book.destroy
      'The book was deleted successfully.'
    end
  end

end