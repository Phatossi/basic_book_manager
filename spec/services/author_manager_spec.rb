require_relative '../../services/author_manager.rb'
#require 'active_record'
#require 'yaml'


describe 'AuthorManager' do

    before :each do

    end

    it 'should add an author' do
      expect(Author).to receive (:create)
      AuthorManager.add('Ryan Holiday', 23)
    end

    it 'should not edit an author who is not found' do
      expect(Author).to receive (:find_by)
      AuthorManager.edit('Ryan Holiday', 'Cal Newport', 32)
    end

    it "should edit author's name" do
      author_record = instance_double(Author, update: true, save: true)
      allow(Author).to receive(:find_by).with(name: 'Ryan Holiday').and_return(author_record)
      expect(author_record).to receive (:save)
      AuthorManager.edit('Ryan Holiday', 'Cal Newport', 0)
    end

    it "should edit author's age" do
      author_record = instance_double(Author, update: true, save: true)
      allow(Author).to receive(:find_by).with(name: 'Ryan Holiday').and_return(author_record)
      expect(author_record).to receive (:save)
      AuthorManager.edit('Ryan Holiday', '', 34)
    end

    it 'should get the author by name' do
      expect(Author).to receive(:find_by)
      AuthorManager.get('Ryan Holiday')
    end


end