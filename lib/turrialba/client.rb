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

    def tweet(id_str)
      self.class.get("/tweet/#{id_str}", @options)
    end
  end
end
