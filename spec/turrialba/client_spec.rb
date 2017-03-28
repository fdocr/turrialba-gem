require "spec_helper"

RSpec.describe Turrialba::Client do
  it "fetches a user by id" do
    client = Turrialba::Client.new
    user = client.user(360962402)
    expect(user.screen_name).to eq('fdoxyz')
  end

  it "puts a user" do
    client = Turrialba::Client.new
    user = client.put_user(fixture('user.json'))
    expect(user.uid).to eq('2436389418')
  end

  it "fetches the next user to be possessed" do
    client = Turrialba::Client.new
    user = client.next_possessed_user
    expect(user).to be_an_instance_of(Turrialba::User)
    expect(user.uid).to match(/\d+/)
  end

  it "puts a tweet" do
    client = Turrialba::Client.new
    tweet_json = fixture('tweet.json')
    tweet = client.put_tweet(tweet_json['user']['id'], tweet_json)
    expect(tweet.id_str).to eq('834171388806180865')
  end

  it "fetches a tweet by id (id_str)" do
    client = Turrialba::Client.new
    tweet = client.tweet('834171388806180865')
    expect(tweet.id_str).to eq('834171388806180865')
  end
end
