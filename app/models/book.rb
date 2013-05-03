require 'google/api_client'

class Book < ActiveRecord::Base
  attr_accessible :title, :author, :thumbnail

  def self.search(query, page = 0, remote_ip = nil)
    client = Google::APIClient.new(
      :key => Yetting.api_key,
      :application_name => Yetting.default_query,
      :application_version => Yetting.application_version,
      :authorization => nil)
    books = client.discovered_api('books', 'v1')
    result = client.execute(
      :api_method => books.volumes.list,
      :authenticated => false,
      :user_ip => remote_ip,
      :parameters => {
        :q => query,
        :country => Yetting.country,
        :maxResults => Yetting.per_page,
        :startIndex => page.to_i * Yetting.per_page
      }
    )
    [result.data.items, result.data.totalItems]
  end
end
