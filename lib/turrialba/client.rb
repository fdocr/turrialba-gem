require 'HTTParty'

module Turrialba
  class Client
    include HTTParty
    base_uri ENV['TURRIALBA_URL'] || 'http://localhost:3000'

    def initialize(auth_token = nil)
      @auth_header = { 'X-AUTH-TOKEN': auth_token || 'hashlol' }
    end

    def user(uid)
      response = self.class.get("/user/#{uid}", headers: @auth_header)
      User.new(response.parsed_response)
    end

    def put_user(hash)
      uid = hash['uid'] || hash['id_str']
      response = self.class.put("/user/#{uid}",
                                  body: filter_user_params(hash),
                                  headers: @auth_header)
      User.new(response.parsed_response)
    end

    def next_possessed_user
      response = self.class.get("/next_possesed_user", headers: @auth_header)
      User.new(response.parsed_response)
    end

    def tweet(id_str)
      response = self.class.get("/tweet/#{id_str}", headers: @auth_header)
      Tweet.new(response.parsed_response)
    end

    def put_tweet(uid, hash)
      response = self.class.put("/user/#{uid}/tweet/#{hash['id_str']}",
                                  body: filter_tweet_params(hash),
                                  headers: @auth_header)
      Tweet.new(response.parsed_response)
    end

    private
    def filter_user_params(hash)
      valid_params = ["screen_name", "name", "location", "description",
        "website", "profile_link_color", "image_url", "banner_url",
        "statuses_count", "favourites_count", "followers_count",
        "friends_count", "listed_count", "protected", "verified", "studder",
        "followers_with_studder", "follower_mean_studder",
        "scrapping_queued_at", "scrapping_request_count", "scrapped_at",
        "possessed_at", "possession_group", "queue_rate_pause",
        "total_scrapping_request_count"]
      hash.select {|k,v| valid_params.include?(k) }
    end

    def filter_tweet_params(hash)
      valid_params = ["id_str", "text", "tweeted_at", "embedded_html",
        "author_id", "in_reply_to_tweet_id", "scrapping_queued_at",
        "scrapping_request_count", "scrapped_at", "favorite_count",
        "retweet_count", "in_reply_to_user_id", "total_scrapping_request_count"]
      hash.select {|k,v| valid_params.include?(k) }
    end
  end
end
