module TwitterSearchClient
  require 'twitter_search'
  
  def twitter_search
    @twitter_search_client  ||= TwitterSearch::Client.new "PhoneBook"
  end
end