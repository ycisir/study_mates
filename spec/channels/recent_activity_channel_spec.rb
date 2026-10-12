# spec/channels/recent_activity_channel_spec.rb
require "rails_helper"

RSpec.describe RecentActivityChannel, type: :channel do
  it "subscribes successfully" do
    subscribe
    expect(subscription).to be_confirmed
  end
end
