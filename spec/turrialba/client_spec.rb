require "spec_helper"

RSpec.describe Turrialba::Client do
  it "fetches a user by id" do
    client = Turrialba::Client.new
    user = client.user(360962402)
    expect(user.screen_name).to eq('fdoxyz')
  end

  it "creates a user" do
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
end
