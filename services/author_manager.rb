require_relative 'manager'
require_relative '../models/author'
require 'pp'
class AuthorManager < Manager
  def self.get(name)
    open_database_connection
    if is_string_blank?(name)
      authors = Author.all
      if !authors
        'No author was found.'
      else
        authors
      end
    else
      author = Author.find_by(name: name)
      if !author
        'Author was not found'
      else
        author
      end
    end
  end

  def self.add(name, age)
    open_database_connection
    author = self.get(name)
    if author.is_a? (Author)
      'An author with this name is already registered in our database.'
    else
    open_database_connection
    name = name.split.map(&:capitalize).join(' ')
    Author.create({
      name: name,
      age: age
      })
    'The author has been registered successfully.'
    end
  end

  def self.edit(old_name, new_name, age)
      open_database_connection
      author = self.get(old_name)
      if !author.is_a? (Author)
        'Author was not found.'
      else
        if !is_string_blank?(new_name)
          new_name = new_name.split.map(&:capitalize).join(' ')
          author.update(name: new_name)
        end
        if is_valid_age?(age)
          author.update(age: age)
        end
        author.save
        'The author was updated successfully.'
      end
  end


  def self.delete(name)
    open_database_connection
    author = AuthorManager.get(name)
    if author.is_a? (Author)
      author.destroy
      'The author was deleted successfully.'
    else
      'Author was not found.'
    end
  end

end
