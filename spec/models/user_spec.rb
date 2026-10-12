require "rails_helper"

RSpec.describe User, type: :model do
  fixtures :users, :rooms

  let(:user) do
    User.new(
      name: "Will Turner",
      email: "will@example.com",
      password: "will123",
      password_confirmation: "will123"
    )
  end

  it "is valid with valid attributes" do
    expect(user).to be_valid
  end

  describe "name" do
    it "must be present" do
      user.name = nil
      expect(user).not_to be_valid
    end

    it "must not be too long" do
      user.name = "j" * 51
      expect(user).not_to be_valid
    end
  end

  describe "email" do
    it "must be present" do
      user.email = nil
      expect(user).not_to be_valid
    end

    it "must not be too long" do
      user.email = "a" * 244 + "example.com"
      expect(user).not_to be_valid
    end

    %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org first.last@foo.jp alice+bob@baz.cn].each do |address|
      it "accepts #{address}" do
        user.email = address
        expect(user).to be_valid
      end
    end

    %w[user@example,com user_at_foo.org user.name@example. foo@bar_baz.com foo@bar+baz.com].each do |address|
      it "rejects #{address}" do
        user.email = address
        expect(user).not_to be_valid
      end
    end

    it "must be unique" do
      duplicate_user = user.dup
      user.save
      expect(duplicate_user).not_to be_valid
    end

    it "is saved as lowercase" do
      mixed_case_email = "Foo@ExAMPle.CoM"
      user.email = mixed_case_email
      user.save
      expect(user.reload.email).to eq(mixed_case_email.downcase)
    end
  end

  describe "password" do
    it "must not be blank" do
      user.password = user.password_confirmation = " " * 6
      expect(user).not_to be_valid
    end

    it "must have a minimum length" do
      user.password = user.password_confirmation = "a" * 5
      expect(user).not_to be_valid
    end
  end

  describe "associations" do
    it "destroys associated rooms when the user is destroyed" do
      user.save
      user.rooms = [ rooms(:rails) ]
      expect { user.destroy }.to change(Room, :count).by(-1)
    end
  end

  describe "following" do
    let(:harry) { users(:harry) }
    let(:ron)   { users(:ron) }

    it "can follow and unfollow a user" do
      expect(harry.following?(ron)).to be false

      harry.follow(ron)
      expect(harry.following?(ron)).to be true
      expect(ron.followers).to include(harry)

      harry.unfollow(ron)
      expect(harry.following?(ron)).to be false
    end

    it "cannot follow itself" do
      harry.follow(harry)
      expect(harry.following?(harry)).to be false
    end
  end

  describe "#feed" do
    let(:harry) { users(:harry) }
    let(:ron)   { users(:ron) }
    let(:jack)  { users(:jack) }

    it "includes rooms from followed users" do
      expect(jack.rooms).not_to be_empty
      jack.rooms.each { |room| expect(harry.feed).to include(room) }
    end

    it "includes the user's own rooms" do
      expect(harry.rooms).not_to be_empty
      harry.rooms.each { |room| expect(harry.feed).to include(room) }
    end

    it "excludes rooms from users not followed" do
      expect(ron.rooms).not_to be_empty
      ron.rooms.each { |room| expect(harry.feed).not_to include(room) }
    end
  end
end
