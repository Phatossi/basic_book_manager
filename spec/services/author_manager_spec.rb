require_relative '../../services/author_manager.rb'
require_relative '../../models/Author.rb'
require 'active_record'
require 'yaml'


describe 'AuthorManager' do

  before :each do

  end

    it 'should add an author' do
      expect(Author).to receive (:create)
      AuthorManager.add('name', 23)
    end
end