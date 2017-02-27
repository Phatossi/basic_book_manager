require_relative '../services/author_manager'
require_relative '../services/book_manager'
require_relative '../services/manager'
require 'active_record'


class InputOutput

  def launch
    puts ">>> Welcome to our book management system <<<"
    puts "Whenever you want to exit from the application, please type exit."
    handle_input
    handle_output
  end

  def handle_input
    display_functions
    function = get_input_function
    display_items
    item = get_input_item
    if item == 'Book'
      handle_book_input(function)
    else
      puts function
      handle_author_input(function)
    end

  end

  def handle_book_input(function)

    case function
      when 'add'
        BookManager.add('','', '')
      when 'list'
        BookManager.get('', '', '')
      when 'update'
        BookManager.edit('', '', '')
      when 'remove'
        BookManager.delete('', '')
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
    puts "These are the services that we offer you for the moment: "
    print_functions
    puts "\nWrite the name of the service that you want to use."
  end

  def display_items
    puts "These are the items that you can modify or get information about: "
    print_items
  end

  def handle_output

  end

  def get_input_function
    input = gets.chomp
    functions = get_functions
    loop do
      if functions.include? (input)
        break
      end
      puts "\nPlease type a valid action:"
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
      puts "Please type a valid item:"
      print_items
      input_item = gets.chomp
    end
  end

  def finish
    puts ">>> Thank you for taking the time to visit us. <<<"
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
    def call_action

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
      name = gets.chomp
      puts 'Type the age of the author:'
      age = gets.chomp
      puts AuthorManager.add(name, age)
    end

    def get_author
      puts 'Type the name of the author that you want to find:'
      pp AuthorManager.get(gets.chomp)
    end

    def edit_author
      puts 'Type the name of the author that you want to edit:'
      old_name = gets.chomp
      loop do
        break if Manager.string_is_not_blank?(old_name)
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
        AuthorManager.edit(old_name, new_name, age)
    end

    def delete_author
      puts 'Type the name of the author: '
      name = gets.chomp
      loop do
        break if Manager.string_is_not_blank?(name)
        puts 'Please type a name of an author that is already registered:'
        name = gets.chomp
      end
      AuthorManager.delete(name)
    end


end

