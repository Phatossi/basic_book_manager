class CreateInitialTables < ActiveRecord::Migration[5.0]
  def self.up
    create_table :books do |t|
      t.string :title
      t.string :isbn
      t.timestamps
    end
    create_table :authors do |t|
      t.string :name
      t.integer :age
    end

    add_column :books, :author_id, :integer

  end
  def self.down
  end

end
