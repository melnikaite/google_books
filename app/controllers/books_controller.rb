class BooksController < ApplicationController
  respond_to :html

  def index
    @query = params[:search] ? params[:search][:query] : Yetting.default_query
    books, @total = Book.search(@query, params[:page], request.remote_ip)
    @books = books.paginate_by_array(:page => params[:page], :total_entries => @total)
    respond_with @books
  end
end
