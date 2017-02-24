require_relative 'manager'
require_relative '../models/book'

class BookManager < Manager

  before_save do |element|
    env = 'default' || ENV['env']
    db_config = YAML::load(File.open('config/database.yml'))[env]
    db_config_admin = db_config
    ActiveRecord::Base.establish_connection(db_config_admin)
  end

  def self.get(title, isbn, author)
    if !string_is_not_blank?(title)
      Book.find_by(title: title)
    elsif !string_is_not_blank?(isbn)
      Book.find_by(isbn: isbn)
    elsif author
      author = AuthorManager.get(name)
      if author
        Book.find_by(author: author)
      end
    else
      "Book was not found"
    end
  end


  def self.add(title, isbn, author)
    if !string_is_not_blank?(title)
      "Book title cannot be empty"
    end
  end

  def self.edit

  end


  def self.delete

  end

end