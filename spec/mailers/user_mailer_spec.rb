require "rails_helper"

RSpec.describe UserMailer, type: :mailer do
  fixtures :users

  let(:user)  { users(:harry) }
  let(:token) { User.new_token }

  describe "account_activation" do
    let(:mail) { UserMailer.account_activation(user, token) }

    it "has the right subject, recipient, and sender" do
      expect(mail.subject).to eq("Account activation")
      expect(mail.to).to eq([ user.email ])
      expect(mail.from).to eq([ ApplicationMailer.default[:from] ])
    end

    it "includes the name, token, and escaped email in the body" do
      expect(mail.body.encoded).to include(user.name)
      expect(mail.body.encoded).to include(token)
      expect(mail.body.encoded).to include(CGI.escape(user.email))
    end
  end

  describe "password_reset" do
    let(:mail) { UserMailer.password_reset(user, token) }

    it "has the right subject, recipient, and sender" do
      expect(mail.subject).to eq("Password reset")
      expect(mail.to).to eq([ user.email ])
      expect(mail.from).to eq([ ApplicationMailer.default[:from] ])
    end

    it "includes the token and escaped email in the body" do
      expect(mail.body.encoded).to include(token)
      expect(mail.body.encoded).to include(CGI.escape(user.email))
    end
  end
end
