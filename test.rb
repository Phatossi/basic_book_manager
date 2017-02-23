#!/usr/bin/env ruby
require 'active_record'
require 'yaml'
require 'require_all'
require 'pp'
require_all 'models/*.rb'

db_config = YAML::load(File.open('config/database.yml'))['default']
ActiveRecord::Base.establish_connection(db_config)

Author.find_each do |p|
  puts "------"
  pp p
end

