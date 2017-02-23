class InputOutput

  def launch
    puts ">>> Welcome to our book management system <<<"
    display_functions
  end

  def display_functions
    #These are the functions that you can use
    puts "These are the services that we offer you for the moment: "
    print_functions
    puts "Write the name of the service that you want to use."
    get_input
  end

  def get_input
    input = gets.chomp
    functions = get_functions
    loop do
      if functions.include? (input)
        break
      end
      puts "Please type a valid action:"
      print_functions
      input = gets.chomp
    end
    call_action

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
end

