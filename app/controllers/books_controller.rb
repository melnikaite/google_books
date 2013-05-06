class BooksController < ApplicationController
  respond_to :html

  def index
    @query = params[:query] || Yetting.default_query
    @books, @total = Book.search_and_paginate(@query, params[:page], request.remote_ip)

    respond_with @books
  end
end
