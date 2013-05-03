require 'spec_helper'

describe BooksController do
  describe 'routing' do
    it 'routes to #index' do
      get('/books').should route_to('books#index')
    end
  end
end
