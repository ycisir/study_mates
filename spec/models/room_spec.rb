require "rails_helper"

RSpec.describe Room, type: :model do
  fixtures :users, :topics

  let(:room) do
    Room.new(
      name: "Ruby on Rails Conf",
      info: "This is Ruby on Rails Conf 2026",
      topic: topics(:ruby),
      user: users(:harry)
    )
  end

  it "is valid with valid attributes" do
    expect(room).to be_valid
  end

  %i[name info topic user].each do |attribute|
    it "requires #{attribute}" do
      room.public_send("#{attribute}=", nil)
      expect(room).not_to be_valid
    end
  end
end