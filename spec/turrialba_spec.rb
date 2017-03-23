require "spec_helper"

RSpec.describe Turrialba do
  it "has a version number" do
    expect(Turrialba::VERSION).not_to be nil
  end

  it "fetches a user" do
    client = Turrialba::Client.new
    user = client.user(360962402)
    expect(user.screen_name).to eq('fdoxyz')
  end
end
