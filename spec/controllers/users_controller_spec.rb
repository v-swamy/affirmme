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

      it "logs in the user" do
        expect(session[:user_id]).to be_present
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

      it "does not log the user in the session" do
        expect(session[:user_id]).not_to be_present
      end
    end
  end

  describe "GET show" do
    
    let(:user) { Fabricate(:user) }

    it_behaves_like "requires sign in" do
      let(:action) { get :show, id: user.id }
    end

    it_behaves_like "access denied" do
      let(:action) { get :show, id: Fabricate(:user).id }
    end

    before { set_current_user(user) }
    before { get :show, id: user.id }

    it "assigns the @user variable to selected user" do
      expect(assigns(:user)).to eq(user)
    end

    it "renders the show template" do
      expect(response).to render_template "show"
    end
  end

  describe "GET edit" do

    let(:user) { Fabricate(:user) }

    it_behaves_like "requires sign in" do
      let(:action) { get :edit, id: user.id }
    end

    it_behaves_like "access denied" do
      let(:action) { get :edit, id: Fabricate(:user).id }
    end

    before { set_current_user(user) }
    before { get :edit, id: user.id }

    it "assigns the @user variable to selected user" do
      expect(assigns(:user)).to eq(user)
    end

    it "renders the edit template" do
      expect(response).to render_template "edit"
    end
  end

  describe "POST update" do
    
    let(:user) { Fabricate(:user, name: "Sydney") }

    before { set_current_user(user) }

    it_behaves_like "requires sign in" do
      let(:action) { post :update, id: user.id, 
        user: Fabricate.attributes_for(:user) }
    end

    it_behaves_like "access denied" do
      let(:action) { post :update, id: Fabricate(:user).id, 
        user: Fabricate.attributes_for(:user) }
    end

    it "assigns the @user variable" do
      post :update, id: user.id, user: Fabricate.attributes_for(:user)
      expect(assigns(:user)).to eq(user)
    end

    context "for valid inputs" do
      
      before {  post :update, id: user.id, 
        user: Fabricate.attributes_for(:user, name: "Vik") }

      it "updates the user with the new info" do
        user.reload
        expect(user.name).to eq("Vik")
      end

      it "sets the flash info message" do
        expect(flash[:info]).to be_present
      end

      it "redirects to the affirmations path" do
        expect(response).to redirect_to(affirmations_path)
      end
    end

    context "for invalid inputs" do
      before {  post :update, id: user.id, 
        user: Fabricate.attributes_for(:user, name: "") }

      it "does not update the user" do
        user.reload
        expect(user.name).to eq("Sydney")
      end

      it "renders the edit template" do
        expect(response).to render_template "edit"
      end
    end
  end
end