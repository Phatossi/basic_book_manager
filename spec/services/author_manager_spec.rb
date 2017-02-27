require_relative '../../services/author_manager'
require_relative '../../services/manager'
describe AuthorManager do

  before do
    allow(AuthorManager).to receive(:open_database_connection)
  end

    it 'should not add an author with a name that was used before' do
      author = double(Author)
      allow(Author).to receive(:find_by).and_return(author)
      allow(File).to receive(:open)
      output = AuthorManager.add('Ryan Holiday', 28)
      expect(output).to eq("An author with this name is already registered in our database.")
    end

    it 'should add an author' do
      author = double(Author, find_by: true)
      allow(Author).to receive(:find_by)
      expect(Author).to receive (:create)
      output = AuthorManager.add('Ryan Holiday', 28)
      expect(output).to eq("The author has been registered successfully.")
    end

    it 'should not edit an author who is not found' do
      expect(Author).to receive (:find_by)
      AuthorManager.edit('Ryan Holiday', 'Cal Newport', 32)
    end

    it "should edit author's name" do
      old_name = 'Ryan Holiday'
      author = instance_double(Author, update: true, save: true)
      allow(Author).to receive(:find_by).with(name: old_name).and_return(author)
      expect(author).to receive (:save)
      output = AuthorManager.edit(old_name, 'Cal Newport', 0)
      expect("The author was updated successfully.").to eq(output)
    end

    it "should edit author's age" do
      name = 'Ryan Holiday'
      author = instance_double(Author, update: true, save: true)
      allow(Author).to receive(:find_by).with(name: name).and_return(author)
      expect(author).to receive (:save)
      output = AuthorManager.edit(name, '', 34)
      expect("The author was updated successfully.").to eq(output)
    end

    it 'should get the author by name' do
      expect(Author).to receive(:find_by)
      AuthorManager.get('Ryan Holiday')
    end

    it 'should get the author without name' do
      author = double(Author)
      allow(Author).to receive(:find_by).and_return(author)
      output = AuthorManager.get('')
      expect(output).to eq (author)
    end

    it 'should not delete the author that is not found' do
      name = 'Ryan Holiday'
      author = instance_double(Author, destroy: true)
      allow(Author).to receive(:find_by).with(name: name)
     #expect(author).to receive(destroy)
      error = AuthorManager.delete(name)
      expect("Author was not found.").to eq(error)
    end

    it 'should delete the author' do
      name = 'Ryan Holiday'
      author = instance_double(Author, destroy: true)
      allow(Author).to receive(:find_by).with(name: name).and_return(author)
      expect(author).to receive(:destroy)
      output = AuthorManager.delete(name)
      expect("The author was deleted successfully.").to eq(output)
    end


end