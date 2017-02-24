require_relative 'manager.rb'

require 'active_record'
require 'require_all'
require 'yaml'
require_relative '../models/Author'

class AuthorManager < Manager




  before_save do |element|
    env = 'default' || ENV['env']
    db_config = YAML::load(File.open('config/database.yml'))[env]
    db_config_admin = db_config
    ActiveRecord::Base.establish_connection(db_config_admin)
  end




  def self.add(name, age)
    Author.create({
      name: name,
      age: age
      })
  end

  def self.edit(old_name, new_name, age)
      author = Author.find_by(name: old_name)
      if author
        if new_name
          author.update(name: new_name)
        end
        if age
          author.update(age: age)
        end
        author.save
        puts "The author was updated successfully."
      else
        puts "Author was not found"
      end
  end

  def self.get

  end

  def self.delete

  end

end
