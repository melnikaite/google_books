require 'google_books_api'
require 'redis_cache'

class Book
  class << self
    def search_and_paginate(query, page, remote_ip)
      books, total = search(query, page, remote_ip)
      books = books.paginate_by_array(:page => page, :total_entries => total)
      [books, total]
    end

    def search(query, page = 1, remote_ip = nil)
      result = RedisCache.set_or_load("#{query}:#{page}") do
        GoogleBooksApi.volumes_list(query, page, remote_ip).to_hash
      end
      [result['items'].to_a, result['totalItems'].to_i]
    end
  end
end
