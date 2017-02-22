class AuthorBook < ActiveRecord::Base
  belongs_to :author_id, :class_name => 'Author'
  belongs_to :book_id, :class_name => 'Book'
end