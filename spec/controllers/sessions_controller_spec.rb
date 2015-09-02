require 'rails_helper'

describe SessionsController do
  describe "POST create" do
    context "with valid credentials" do

      let(:user) { Fabricate(:user) }

      before do
        post :create, email: user.email, password: user.password
      end

      it "puts signed in user in the session" do
        expect(session[:user_id]).to eq(user.id)
      end

      it "redirects to the affirmations index path" do
        expect(response).to redirect_to affirmations_path
      end

      it "sets the success flash message" do
        expect(flash[:success]).not_to be_blank
      end
    end

    context "with invalid credentials" do

      before do
        user = Fabricate(:user)
        post :create, email: user.email, password: user.password + 'asdf'
      end

      it "does not put the signed in user in the session" do
        expect(session[:user_id]).to be_nil
      end
      
      it "redirects to home path" do
        expect(response).to redirect_to root_path
      end

      it "sets the danger flash message" do
        expect(flash[:danger]).not_to be_blank
      end
    end
  end
end