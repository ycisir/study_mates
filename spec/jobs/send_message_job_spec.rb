require "rails_helper"

RSpec.describe SendMessageJob, type: :job do
  fixtures :users, :rooms

  let(:message) do
    Message.create!(body: "Hello job test", user: users(:ron), room: rooms(:ruby))
  end

  it "executes without raising" do
    expect { described_class.perform_now(message) }.not_to raise_error
  end

  it "can be enqueued with a message" do
    ActiveJob::Base.queue_adapter = :test
    expect { described_class.perform_later(message) }
      .to have_enqueued_job(described_class).with(message)
  end
end