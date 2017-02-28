require 'active_record'
class Author < ActiveRecord::Base
  has_many :book, :class_name => 'Book', dependent: :destroy
end
