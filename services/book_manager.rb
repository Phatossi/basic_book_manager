require_relative 'manager'
require_relative 'author_manager'
require_relative '../models/book'

class BookManager < Manager


  def self.get(title, isbn, author)
    open_database_connection
    if string_is_not_blank?(title)
      Book.find_by(title: title)
    elsif string_is_not_blank?(isbn)
      Book.find_by(isbn: isbn)
    elsif author
      author = AuthorManager.get(name)
      if author
        Book.find_by(author: author)
      end
    else
      'Book was not found.'
    end
  end


  def self.add(title, isbn, author)
    if !string_is_not_blank?(title)
      'Book title cannot be empty.'
    elsif !string_is_not_blank?(isbn)
      'Book ISBN cannot be empty.'
    elsif !author
      'Book author cannot be empty.'
    else
      open_database_connection
      found_author = AuthorManager.get(author.name)
      if !found_author
       found_author = Author.create({
                name: author.name,
                age: author.age
                })
      end
      Book.create({
          title: title,
          isbn: isbn,
          author: author
              })
      'Book was added successfully.'
    end
  end

  def self.edit(old_title, title, isbn)
    if !string_is_not_blank? (old_title)
      'Please provide the title of the book.'
    else
    open_database_connection
    book = BookManager.get(old_title, '', '')
    if !book
        'Book was not found.'
    else
      if !string_is_not_blank?(title)
        book.update(title: title)
      end
      if !string_is_not_blank?(isbn)
        book.update(isbn: isbn)
      end
      book.save
      'The book was updated successfully.'
    end
    end
  end


  def self.delete(title, isbn)
    open_database_connection
    book = BookManager.get(title, nil, nil)
    if !book
      'Book was not found.'
    else
      book.destroy
      'The book was deleted successfully.'
    end
  end

end