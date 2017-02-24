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


  def self.get(name)
    Author.find_by(name: name)
  end

  def self.add(name, age)
    Author.create({
      name: name,
      age: age
      })
  end

  def self.edit(old_name, new_name, age)
      author =  get(old_name)
      if author
        if new_name && !new_name.to_s.empty?
          author.update(name: new_name)
        end
        if is_valid_age?(age)
          author.update(age: age)
        end
        author.save
        "The author was updated successfully."
      else
        "Author was not found"
      end
  end

  def self.delete(name)

  end

  private
  def AuthorManager.is_valid_age? (string)
    true if Float(string) > 0 rescue false
  end

end
