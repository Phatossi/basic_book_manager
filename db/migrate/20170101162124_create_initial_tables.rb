class CreateInitialTables < ActiveRecord::Migration[5.0]
  def self.up

    create_table :authors do |t|
      t.string :name
      t.integer :age
    end

    create_table :books do |t|
      t.string :title
      t.string :isbn
      t.timestamps
    end

    create_table :authors_books do |t|
      t.references :author, index: true
      t.references :book, index: true
      t.timestamps
    end

    add_column :books, :author_book_id, :integer
    add_column :authors, :author_book_id, :integer


  end
  def self.down
  end

end
