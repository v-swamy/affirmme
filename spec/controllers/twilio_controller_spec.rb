require 'rails_helper'


describe TwilioController do
  describe "POST start" do

    it_behaves_like "requires sign in" do
      let(:action) { post :start }
    end

    context "user does not have any affirmations" do

      before do
        set_current_user
        post :start
      end

      it "sets the flash danger message" do
        expect(flash[:danger]).to be_present
      end

      it "redirects to the affirmations path" do
        expect(response).to redirect_to affirmations_path
      end
    end

    context "for a successful message" do

      let(:message) { double(:message, successful?: true) }

      before do
        user = Fabricate(:user)
        affirmation = Fabricate(:affirmation, user: user)
        set_current_user(user)
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
        user = Fabricate(:user)
        affirmation = Fabricate(:affirmation, user: user)
        set_current_user(user)
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

  describe "POST status" do

    context "for successfully delivered messages" do

      let!(:user) { Fabricate(:user, phone: "5555555555") }
      let!(:affirmation) { Fabricate(:affirmation, user: user) }

      before { post :status, MessageStatus: "delivered", To: "+15555555555" }

      it "sets the user variable to the user of the message" do
        expect(assigns(:user)).to eq(user)
      end

      it "queues the TwilioWorker job" do
        expect(TwilioWorker.jobs.size).to eq(1)
      end
    end
  end
end