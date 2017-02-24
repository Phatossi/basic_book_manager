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



end