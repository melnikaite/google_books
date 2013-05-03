require 'spec_helper'

describe BooksController do
  describe 'GET index' do
    let(:book) { FactoryGirl.create(:book) }

    it 'assigns all books as @books' do
      get :index
      assigns(:books).should eq([book])
    end
  end
end
