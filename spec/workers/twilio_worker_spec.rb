require 'rails_helper'

describe TwilioWorker do
  describe '#perform', :vcr do
    it "calls the TwilioWrapper::Messages.create method" do
      user = Fabricate(:user)
      affirmation = Fabricate(:affirmation, user: user)
      worker = TwilioWorker.new
      expect(TwilioWrapper::Messages).to receive(:create)
      worker.perform(user.id, "http://www.nowhere.com")
    end
  end
end