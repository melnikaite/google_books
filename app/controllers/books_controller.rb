class BooksController < ApplicationController
  respond_to :html

  def index
    @query = params[:search] ? params[:search][:query] : 'ruby on rails'
    @books = Book.last(100)
    respond_with @books
  end
end
