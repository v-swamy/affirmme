require 'rails_helper'

describe UsersController do
  describe "GET new" do
    it "sets the @user variable" do
      get :new
      expect(assigns(:user)).to be_a_new(User)
    end
  end

  describe "POST create" do
    context "with valid inputs" do
      before { post :create, user: Fabricate.attributes_for(:user) }

      it "creates a new user" do
        expect(User.count).to eq(1)
      end

      it "redirects to the affirmations path" do
        expect(response).to redirect_to affirmations_path
      end

      it "sets the flash success message" do
        expect(flash[:success]).to be_present
      end
    end

    context "with invalid inputs" do
      before { post :create, user: {name: "Vik"} }

      it "does not create a new user" do
        expect(User.count).to eq(0)
      end

      it "renders the new template" do
        expect(response).to render_template 'users/new'
      end
    end
  end
end