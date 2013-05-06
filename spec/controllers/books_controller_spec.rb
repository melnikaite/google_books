require 'spec_helper'
require 'benchmark'

describe BooksController, :vcr => { :cassette_name => 'Book' } do
  describe 'GET index' do
    it 'assigns all books as @books' do
      get :index
      assigns(:books).should be_a(Array)
    end
  end

  describe 'performance' do
    it 'takes time' do
      Benchmark.realtime{
        5000.times do
          get :index
        end
      }.should < 60
    end
  end
end
