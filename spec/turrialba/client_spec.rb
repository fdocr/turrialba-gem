require "spec_helper"

RSpec.describe Turrialba::Client do
  it "fetches a user by id" do
    client = Turrialba::Client.new
    user = client.user(360962402)
    expect(user.screen_name).to eq('fdoxyz')
  end

  it "fetches a user by username" do
    client = Turrialba::Client.new
    user = client.username('fdoxyz')
    expect(user.uid).to eq('360962402')
  end

  it "puts a user" do
    client = Turrialba::Client.new
    user = client.put_user(fixture('user.json'))
    expect(user.uid).to eq('2436389418')
  end

  it "posts a user distribution" do
    client = Turrialba::Client.new
    uid = 360962402

    distribution = { 0 => 5, 50 => 4, 100 => 3, 200 => 2, 400 => 1 }
    favorites_data = {
      followers: distribution,
      following: distribution,
      favorites: distribution,
      statuses: distribution,
    }
    retweets_data = {
      favorites: distribution,
      retweets: distribution
    }

    distribution = client.post_user_distribution(uid, 'favorites', 60*60, favorites_data)
    expect(distribution).to be true

    distribution = client.post_user_distribution(uid, 'retweets', 60*60, retweets_data)
    expect(distribution).to be true
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
    tweet = client.put_tweet(tweet_json[:user][:id], tweet_json)
    expect(tweet.id_str).to eq('834171388806180865')
  end

  it "posts a tweet distribution" do
    client = Turrialba::Client.new
    tweet_json = fixture('tweet.json')

    distribution = { 0 => 5, 50 => 4, 100 => 3, 200 => 2, 400 => 1 }
    new_data = {
      followers: distribution,
      following: distribution,
      favorites: distribution,
      statuses: distribution,
    }

    distribution = client.post_tweet_distribution(tweet_json[:id_str], 'retweets', 60*60, new_data)
    expect(distribution).to be true
  end

  it "fetches a tweet by id (id_str)" do
    client = Turrialba::Client.new
    tweet = client.tweet('834171388806180865')
    expect(tweet.id_str).to eq('834171388806180865')
  end

  it "puts a favorite connection user->tweet" do
    client = Turrialba::Client.new
    success = client.put_favorite('2436389418', '834171388806180865')
    expect(success).to be true
  end

  it "puts a retweet connection user->tweet" do
    client = Turrialba::Client.new
    success = client.put_retweet('2436389418', '834171388806180865')
    expect(success).to be true
  end

  it "puts a follower connection user->user" do
    client = Turrialba::Client.new
    success = client.put_follower_connection('360962402', '2436389418')
    expect(success).to be true
  end
end
