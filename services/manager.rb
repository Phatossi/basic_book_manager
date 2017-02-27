require 'active_record'
require 'require_all'
require 'yaml'

class Manager < ActiveRecord::Base


  def self.string_is_blank? (string)
    if string || !string.to_s.empty?
      false
    else
      true
    end
  end

  private
  def self.open_database_connection
    env = 'default' || ENV['env']
    db_config = YAML::load(File.open('config/database.yml'))[env]
    db_config_admin = db_config
    ActiveRecord::Base.establish_connection(db_config_admin)
  end


  def self.is_valid_age? (string)
    true if Float(string) > 0 rescue false
  end


end