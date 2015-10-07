require 'rails_helper'

describe TwilioWrapper do
  describe TwilioWrapper::Messages do
    describe ".create", :vcr do
      it "sends a successful message" do
        user = Fabricate(:user, phone: "5005555555")
        affirmation = Fabricate(:affirmation, text: "First affirmation", 
          user: user)
        user.set_next_affirmation_id
        url = "http://affirmme.herokuapp.com"
        message = TwilioWrapper::Messages.create(user, url)
        expect(message).to be_successful
      end

      it "sends an unsuccessful message", :vcr do
        user = Fabricate(:user, phone: "5005550001")
        affirmation = Fabricate(:affirmation, text: "First affirmation", 
          user: user)
        user.set_next_affirmation_id
        url = "http://affirmme.herokuapp.com"
        message = TwilioWrapper::Messages.create(user, url)
        expect(message).not_to be_successful
      end

      it "returns the error message for the unsuccessful message", :vcr do
        user = Fabricate(:user, phone: "5005550001")
        affirmation = Fabricate(:affirmation, text: "First affirmation", 
          user: user)
        user.set_next_affirmation_id
        url = "http://affirmme.herokuapp.com"
        message = TwilioWrapper::Messages.create(user, url)
        expect(message.error_message).to eq("The 'To' number +15005550001 is not a valid phone number.")
      end
    end
  end
end