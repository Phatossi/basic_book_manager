class Book < ActiveRecord::Base
  belongs_to :author, :class_name => 'Author'

  attr_accessor :title, :isbn

end
