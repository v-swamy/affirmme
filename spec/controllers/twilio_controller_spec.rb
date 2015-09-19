require 'rails_helper'


describe TwilioController do
  describe "POST start" do

    it_behaves_like "requires sign in" do
      let(:action) { post :start }
    end

    context "for a successful message" do

      let(:message) { double(:message, successful?: true) }

      before do
        set_current_user
        expect(TwilioWrapper::Messages).to receive(:create).and_return(message)
      end

      it "redirects to the affirmations path" do
        post :start
        expect(response).to redirect_to affirmations_path
      end

      it "sets the flash success message" do
        post :start
        expect(flash[:success]).to be_present
      end
    end

    context "for an unsucessful message" do
      let(:message) { double(:message, successful?: false, 
        error_message: "Your number had an error.") }

      before do
        set_current_user
        expect(TwilioWrapper::Messages).to receive(:create).and_return(message)
      end

      it "redirects to the affirmations path" do
        post :start
        expect(response).to redirect_to affirmations_path
      end

      it "sets the flash danger message" do
        post :start
        expect(flash[:danger]).to be_present
      end
    end
  end
end