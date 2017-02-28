require_relative '../services/author_manager'
require_relative '../services/book_manager'
require_relative '../services/manager'
require 'active_record'


class InputOutput

  def launch
    start
    handle_input
    finish
  end

  def start
    puts "\n\n>>> Welcome to our book management system. We wish you a joyful experience. <<<\n\n"
  end

  def finish
    puts "\n\n>>> Thank you for taking the time to visit us. Happy reading. <<<\n\n"
  end

  def handle_input
    loop do
      display_functions
      function = get_input_function
      break if function == 'quit'
      display_items
      item = get_input_item
      supported_items = get_supported_items
      loop do
        break if supported_items.include?(item)
        break if item == 'quit'
        puts 'Please provide a valid item:'
        print_items
        item = gets.chomp
      end
      break if item == 'quit'
      if item == 'book'
        handle_book_input(function)
      else
        handle_author_input(function)
      end
      puts 'If you want to get out of our library, please type quit'
    end
  end

  def handle_book_input(function)
    case function
      when 'add'
        add_book
      when 'list'
        get_book
      when 'update'
        edit_book
      when 'remove'
        delete_book
    end
  end

  def handle_author_input(function)
    case function
      when 'add'
        add_author
      when 'list'
        get_author
      when 'update'
        edit_author
      when 'remove'
        delete_author
    end
  end

  def display_functions
    puts 'These are the services that we offer you for the moment: '
    print_functions
  end

  def display_items
    puts 'These are the items that you can modify or get information about:'
    print_items
  end

  def get_input_function
    puts 'Write the name of the service that you want to use:'
    input = gets.chomp
    functions = get_functions
    loop do
        break if functions.include? (input)
        break if input == 'quit'
        puts 'Please type a valid action:'
        print_functions
        input = gets.chomp
    end
    input
  end

  def get_input_item
    supported_items = get_supported_items
    input_item = gets.chomp
    loop do
      break if supported_items.include?(input_item)
      break if input_item == 'quit'
      puts 'Please type a valid item:'
      print_items
      input_item = gets.chomp
    end
    input_item
  end

  private
    def get_functions
     ['add', 'update', 'list', 'remove']
    end

    def print_functions
      functions = get_functions
      functions.each do |element|
        p element
      end
    end

  def get_supported_items
      ['author', 'book']
    end

    def print_items
      items = get_supported_items
      items.each do |element|
        p element
      end
    end

    def add_author
      puts 'Type the name of the author:'
      name = get_valid_input('name')
      puts 'Type the age of the author:'
      age = gets.chomp
      puts AuthorManager.add(name, age)
    end

    def get_author
      puts 'Type the name of the author that you want to find. If you want to see the list of all author, press Enter:'
      pp AuthorManager.get(gets.chomp)
    end

    def edit_author
      puts 'Type the name of the author that you want to edit:'
      old_name = gets.chomp
      loop do
        break if !Manager.is_string_blank?(old_name)
        old_name = gets.chomp
      end
      author = AuthorManager.get(old_name)
      if !author
        puts 'Author was not found'
        return
      end
        puts 'If you want to change the name, type the new name of the author:'
        new_name = gets.chomp
        puts 'Type the new age of the author:'
        age = gets.chomp
        puts AuthorManager.edit(old_name, new_name, age)
    end

    def delete_author
      puts 'Type the name of the author: '
      name = gets.chomp
      loop do
        break if !Manager.is_string_blank?(name)
        puts 'Please type a name of an author that is already registered:'
        name = gets.chomp
      end
      puts AuthorManager.delete(name)
    end

    def add_book
      puts 'Type the title of the book that you want to add:'
      title = get_valid_input('title')
      puts 'Type the ISBN:'
      isbn = get_valid_input('isbn')
      puts 'Type the name of the author of this book:'
      author_name = get_valid_input('name')
      author = AuthorManager.get(author_name)
      if !author.is_a? (Author)
        puts "It turns out that this user is not added to our database yet. We are glad to have you help us add this new author as well.\n"
        add_author
        puts "\nPlease write the name of the author once again:"
        author_name = get_valid_input('name')
        author =  AuthorManager.get(author_name)
      end
     puts BookManager.add(title, isbn, author)
    end

   def get_book
    puts 'Do you want to find the book by title, isbn, or author?'
    puts 'Type all if you want to see all the books:'
    input = gets.chomp
     loop do
       break if (input == 'author') || (input == 'isbn') || (input == 'title') || (input == 'all')
       puts 'Please type a valid value (e.g. title, isbn, author)'
       input =  gets.chomp
     end
    case input
      when 'all'
        get_all_book
      when 'title'
        get_book_by_title
      when 'isbn'
        get_book_by_isbn
      when 'author'
        get_book_by_author
     end
    end

    def get_all_book
      pp BookManager.get('all', '', '')
    end


    def get_book_by_title
      puts 'Type the name of the title'
      title = get_valid_input('title')
      pp BookManager.get(title, '', '')
    end

    def get_book_by_isbn
      puts 'Type the isbn of the title'
      isbn = get_valid_input('isbn')
      pp BookManager.get('', isbn, '')
    end

    def get_book_by_author
      author = get_author
      pp BookManager.get('', '', author)
    end

   def edit_book
      puts 'Do you want to change the title or the isbn of a book?'
      input = gets.chomp
      loop do
        break if (input == 'title') || (input == 'isbn')
        puts 'Please type a valid input (e.g. title, isbn):'
        input = gets.chomp
      end
      case input
        when 'title'
         edit_book_title
         when 'isbn'
         edit_book_isbn
        end
   end

    def edit_book_title
      puts 'Type the old title:'
      old_title = get_valid_input('title')
      puts 'Type the new title:'
      new_title = get_valid_input('title')
      puts BookManager.edit(old_title, new_title, '')
    end

    def edit_book_isbn
      puts 'Type the book title:'
      old_title = get_valid_input('title')
      puts 'Type the ISBN:'
      isbn = get_valid_input('isbn')
      puts BookManager.edit(old_title, '', isbn)
    end

    def delete_book
      puts 'Type the title of the book that you want to remove:'
      title = get_valid_input('title')
      puts BookManager.delete(title)
    end


  private

    def get_valid_input(string)
      input = gets.chomp
      loop do
        break !Manager.is_string_blank?(input)
        puts 'Please provide a valid value for: ' + string
        input = gets.chomp
      end
      input
    end

end

