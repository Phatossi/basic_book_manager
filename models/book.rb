require 'active_record'
class Book < ActiveRecord::Base

  belongs_to :author, :class_name => 'Author'


end
