require_relative 'manager.rb'

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


  def self.get

  end

  def self.delete

  end

end