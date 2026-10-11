require "rails_helper"

RSpec.describe Topic, type: :model do
  let(:topic) { Topic.new(name: "Ruby on Rails", slug: "ruby-on-rails") }

  it "is valid with valid attributes" do
    expect(topic).to be_valid
  end

  it "requires a name" do
    topic.name = nil
    expect(topic).not_to be_valid
  end

  it "normalizes the name" do
    topic = Topic.new(name: "  ruby on RAILS  ")
    expect(topic.name).to eq("Ruby On Rails")
  end
end