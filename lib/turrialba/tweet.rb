require 'turrialba/base'

module Turrialba
  class Tweet < Turrialba::Base
    attr_reader :id_str, :text, :tweeted_at, :embedded_html, :author_id,
      :in_reply_to_tweet_id, :created_at, :updated_at, :scrapping_queued_at,
      :scrapping_request_count, :scrapped_at, :favorite_count, :retweet_count,
      :in_reply_to_user_id, :total_scrapping_request_count
  end
end
