require "rails_helper"

RSpec.describe Relationship, type: :model do
  fixtures :users

  let(:relationship) do
    Relationship.new(follower_id: users(:ron).id, followed_id: users(:harry).id)
  end

  it "is valid with valid attributes" do
    expect(relationship).to be_valid
  end

  it "requires a follower_id" do
    relationship.follower_id = nil
    expect(relationship).not_to be_valid
  end

  it "requires a followed_id" do
    relationship.followed_id = nil
    expect(relationship).not_to be_valid
  end
end