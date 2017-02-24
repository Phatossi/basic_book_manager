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
    if string_is_not_blank?(name)
      Author.find_by(name: name)
    end
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
        if string_is_not_blank?(new_name)
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
    author = AuthorManager.get(name)
    if author
      author.destroy
      "The author was deleted successfully."
    else
      "Author was not found"
    end
  end

  private
  def AuthorManager.is_valid_age? (string)
    true if Float(string) > 0 rescue false
  end

  def AuthorManager.string_is_not_blank? (string)
    if string && !string.to_s.empty?
      true
    else
      false
    end
  end

end
