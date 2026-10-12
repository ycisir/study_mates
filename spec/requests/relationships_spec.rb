require "rails_helper"

RSpec.describe "Relationships", type: :request do
  fixtures :users

  let(:harry) { users(:harry) }
  let(:ron)   { users(:ron) }
  let(:jack)  { users(:jack) }

  before { sign_in_as(harry) }

  describe "POST /relationships" do
    it "follows a user the standard way" do
      expect {
        post relationships_path, params: { followed_id: ron.id }
      }.to change { harry.following.count }.by(1)
      expect(response).to redirect_to(ron)
    end

    it "follows a user with Hotwire" do
      expect {
        post relationships_path(format: :turbo_stream), params: { followed_id: ron.id }
      }.to change { harry.following.count }.by(1)
    end
  end

  describe "DELETE /relationships/:id" do
    let!(:relationship) do
      harry.follow(ron)
      harry.active_relationships.find_by(followed_id: ron.id)
    end

    it "unfollows a user the standard way" do
      expect { delete relationship_path(relationship) }.to change { harry.following.count }.by(-1)
      expect(response).to have_http_status(:see_other)
      expect(response).to redirect_to(ron)
    end

    it "unfollows a user with Hotwire" do
      expect {
        delete relationship_path(relationship, format: :turbo_stream)
      }.to change { harry.following.count }.by(-1)
    end
  end

  # Replaces the commented-out follow pages tests (they asserted 422, which looked wrong)
  describe "following and followers pages" do
    it "lists the users being followed" do
      get following_user_path(harry)
      expect(response).to have_http_status(:success)
      expect(response.body).to include(user_path(jack))
    end

    it "lists followers" do
      ron.follow(harry) unless ron.following?(harry)
      get followers_user_path(harry)
      expect(response).to have_http_status(:success)
      expect(response.body).to include(user_path(ron))
    end
  end
end
