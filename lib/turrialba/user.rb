require 'turrialba/base'

module Turrialba
  class User < Turrialba::Base
    attr_reader :id, :email, :uid, :secret, :provider, :created_at,
                :updated_at, :token, :screen_name, :name, :location,
                :description, :website, :profile_link_color, :image_url,
                :banner_url, :statuses_count, :favourites_count,
                :followers_count, :friends_count, :listed_count, :protected,
                :verified, :default_profile_image, :default_profile, :studder,
                :followers_with_studder, :follower_mean_studder,
                :scrapping_queued_at, :scrapping_request_count, :scrapped_at,
                :possessed_at, :possession_group, :queue_rate_pause,
                :total_scrapping_request_count
  end
end
