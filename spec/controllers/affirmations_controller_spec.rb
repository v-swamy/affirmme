require 'rails_helper'

describe AffirmationsController do
  describe "GET index" do
    it_behaves_like "requires sign in" do
      let(:action) { get :index }
    end

    it "sets the @affirmations variable to the current user's affirmations" do
      user = Fabricate(:user)
      set_current_user(user)
      affirmation = Fabricate(:affirmation, user: user)
      get :index
      expect(assigns(:affirmations)).to eq([affirmation])
    end
  end

  describe "GET new" do
    it_behaves_like "requires sign in" do
      let(:action) { get :new }
    end

    it "sets the @affirmation variable to a new instance" do
      set_current_user
      get :new
      expect(assigns(:affirmation)).to be_a_new(Affirmation)
    end
  end

  describe "GET edit" do
    
    let(:affirmation) { Fabricate(:affirmation) }

    it_behaves_like "requires sign in" do
      let(:action) { get :edit, id: affirmation.id }
    end

    it_behaves_like "access denied" do
      let(:action ) { get :edit, id: affirmation.id }
    end

    it "assigns the @affirmation variable to the selected affirmation" do
      set_current_user
      get :edit, id: affirmation.id
      expect(assigns(:affirmation)).to eq(affirmation)
    end
  end

  describe "POST update" do
    
    let(:user) { Fabricate(:user) }
    let(:affirmation) { Fabricate(:affirmation, user: user, text: "This is the text.") }
    let(:affirmation2) { Fabricate(:affirmation) }

    before { set_current_user(user) }

    it_behaves_like "requires sign in" do
      let(:action) { post :update, id: affirmation.id, 
        affirmation: Fabricate.attributes_for(:affirmation) }
    end

    it_behaves_like "access denied" do
      let(:action) { post :update, id: affirmation2.id, 
        affirmation: Fabricate.attributes_for(:affirmation) }
    end

    it "assigns the @affirmation variable to the selected affirmation" do
      set_current_user
      post :update, id: affirmation.id
      expect(assigns(:affirmation)).to eq(affirmation)
    end

    context "with valid inputs" do
      
      it "updates the affirmation record" do
        post :update, id: affirmation.id, affirmation: { text: "Updated text." }
        affirmation.reload
        expect(affirmation.text).to eq("Updated text.")
      end

      it "redirects to affirmations path" do
        post :update, id: affirmation.id, 
          affirmation: Fabricate.attributes_for(:affirmation)
        expect(response).to redirect_to(affirmations_path)
      end
    end

    context "with invalid inputs" do
      
      it "does not update the affirmation record" do
        post :update, id: affirmation.id, affirmation: { text: "" }
        affirmation.reload
        expect(affirmation.text).to eq("This is the text.")
      end

      it "renders the edit page" do
        post :update, id: affirmation.id, affirmation: { text: "" }
        affirmation.reload
        expect(response).to render_template "edit"
      end
    end
  end

  describe "DELETE destroy" do

    let(:user) { Fabricate(:user) }
    let(:affirmation) { Fabricate(:affirmation, user: user) }
    let(:affirmation2) { Fabricate(:affirmation) }

    before { set_current_user(user) }

    it_behaves_like "requires sign in" do
      let(:action) { delete :destroy, id: affirmation.id }
    end

    it_behaves_like "access denied" do
      let(:action) { delete :destroy, id: affirmation2.id }
    end

    before { delete :destroy, id: affirmation.id }

    it "assigns the @affirmation variable to the selected affirmation" do
      expect(assigns(:affirmation)).to eq(affirmation)
    end

    it "deletes the affirmation record" do
      expect(Affirmation.all.count).to eq(0)
    end

    it "sets the flash warning message" do
      expect(flash[:warning]).to be_present
    end

    it "redirects to the affirmations path" do
      expect(response).to redirect_to affirmations_path
    end
  end
end
