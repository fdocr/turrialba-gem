require 'HTTParty'

module Turrialba
  class Client
    include HTTParty
    base_uri ENV['TURRIALBA_URL'] || 'http://localhost:3000'

    def initialize(auth_token = 'hashlol')
      @auth_header = { 'X-AUTH-TOKEN': auth_token }
    end

    def user(uid)
      response = self.class.get("/user/#{uid}", headers: @auth_header)
      User.new(response.parsed_response)
    end

    def username(screen_name)
      response = self.class.get("/user/#{screen_name}/username", headers: @auth_header)
      User.new(response.parsed_response)
    end

    def put_user(hash)
      uid = hash[:uid] || hash[:id_str]
      response = self.class.put("/user/#{uid}",
                                  body: filter_user_params(hash),
                                  headers: @auth_header)
      User.new(response.parsed_response)
    end

    def post_user_distribution(uid, source, mining_cost, distribution)
      params = {
        source: source,
        mining_cost: mining_cost,
      }
      params[:followers] = distribution[:followers].to_json if !distribution[:followers].nil?
      params[:following] = distribution[:following].to_json if !distribution[:following].nil?
      params[:favorites] = distribution[:favorites].to_json if !distribution[:favorites].nil?
      params[:statuses] = distribution[:statuses].to_json if !distribution[:statuses].nil?
      params[:retweets] = distribution[:retweets].to_json if !distribution[:retweets].nil?

      response = self.class.post("/user/#{uid}/distribution", body: params, headers: @auth_header)
      response.code == 200
    end

    def next_possessed_user
      response = self.class.get("/next_possessed_user", headers: @auth_header)
      if response.code == 200
        User.new(response.parsed_response)
      else
        nil
      end
    end

    def tweet(id_str)
      response = self.class.get("/tweet/#{id_str}", headers: @auth_header)
      Tweet.new(response.parsed_response)
    end

    def put_tweet(uid, hash)
      response = self.class.put("/user/#{uid}/tweet/#{hash[:id_str]}",
                                  body: filter_tweet_params(hash),
                                  headers: @auth_header)
      Tweet.new(response.parsed_response)
    end

    def post_tweet_distribution(id_str, source, mining_cost, distribution)
      response = self.class.post("/tweet/#{id_str}/distribution",
                                  body: {
                                    source: source,
                                    mining_cost: mining_cost,
                                    followers: distribution[:followers].to_json,
                                    following: distribution[:following].to_json,
                                    favorites: distribution[:favorites].to_json,
                                    statuses: distribution[:statuses].to_json
                                  },
                                  headers: @auth_header)
      response.code == 200
    end

    def put_favorite(uid, id_str)
      response = self.class.put("/user/#{uid}/favorite/#{id_str}",
                                  headers: @auth_header)
      response.code == 200
    end

    def put_retweet(uid, id_str)
      response = self.class.put("/user/#{uid}/retweet/#{id_str}",
                                  headers: @auth_header)
      response.code == 200
    end

    def put_follower_connection(uid, follower_uid)
      response = self.class.put("/user/#{uid}/follows/#{follower_uid}/",
                                  headers: @auth_header)
      response.code == 200
    end

    private
    def filter_user_params(hash)
      valid_params = [:screen_name, :name, :location, :description,
        :website, :profile_link_color, :image_url, :banner_url,
        :statuses_count, :favourites_count, :followers_count,
        :friends_count, :listed_count, :protected, :verified, :studder,
        :followers_with_studder, :follower_mean_studder,
        :scrapping_queued_at, :scrapping_request_count, :scrapped_at,
        :possessed_at, :possession_group, :queue_rate_pause,
        :total_scrapping_request_count]
      hash.select {|k,v| valid_params.include?(k)}

      # Remove Unicode NULL character from Strings (it makes Postgres cry)
      hash.transform_values! {|v| v.class == String ? v.gsub("\u0000", "") : v}
    end

    def filter_tweet_params(hash)
      valid_params = [:id_str, :text, :tweeted_at, :embedded_html,
        :author_id, :in_reply_to_tweet_id, :scrapping_queued_at,
        :scrapping_request_count, :scrapped_at, :favorite_count,
        :retweet_count, :in_reply_to_user_id, :total_scrapping_request_count]
      hash.select {|k,v| valid_params.include?(k)}

      # Remove Unicode NULL character from Strings (it makes Postgres cry)
      hash.transform_values! {|v| v.class == String ? v.gsub("\u0000", "") : v}
    end
  end
end
