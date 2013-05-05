require 'google/api_client'

class Book < ActiveRecord::Base
  attr_accessible :title, :author, :thumbnail
  def self.search(query, page = 1, remote_ip = nil)
    if result = $redis.get("#{query}:#{page}")
      result = Marshal.load(result)
    else
      result = volumes_list(query, page, remote_ip).to_hash
      $redis.setex("#{query}:#{page}", Yetting.cache_ttl, Marshal.dump(result))
    end
    [result['items'].to_a, result['totalItems'].to_i]
  end

  private

  def self.volumes_list(query, page, remote_ip)
    start_index = page.to_i > 1 ? (page.to_i - 1) * Yetting.per_page + 1 : 0
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
        :startIndex => start_index
      }
    )

    result.data
  end
end
