require_relative '../models/author'
require_relative 'manager'
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
    else
      "Author was not found"
    end
  end

  def self.add(name, age)
    author = AuthorManager.get(name)
    if author
      "An author with this name is already registered in our database."
    else
    Author.create({
      name: name,
      age: age
      })
    "The author has been registered successfully."
    end
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
        "Author was not found."
      end
  end

  def self.delete(name)
    author = AuthorManager.get(name)
    if author
      author.destroy
      "The author was deleted successfully."
    else
      "Author was not found."
    end
  end

end
